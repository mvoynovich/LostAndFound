/*********** start constants ***********/

// while these colors may seem vague, the more vague the color is, the more likely the user is to find it from a search
// ex. if losing a maroon hoodie, searching "red" vs "light red" and "dark red" is quicker and less prone to discrepancies
const COLOR_NAMES = [
  "Red", "Orange", "Yellow", "Green", "Blue", "Purple",
  "White", "Gray", "Black", "Pink", "Brown", "Transparent",
  "Rainbow", "Other (specify in comments)"
];

const ITEM_TYPES = [
  "Headwear",
  "Sweaters & jackets",
  "Jewelry & bracelets",
  "Misc. clothing",
  "ID, Keys, Wallet, etc.",
  "Wearable tech",
  "Device chargers",
  "Laptops & large tech",
  "Misc. tech",
  "Other (specify in comments)"
];

// prevent modification to arrays
Object.freeze(COLOR_NAMES);
Object.freeze(ITEM_TYPES);

/*********** end constants ***********/
/*********** start onload events ***********/

$(document).ready(async () => {
  // add item types and color names to any dropdowns on the DOM
  $("select.item-type-list").each(function() {
    $(this).html(
      [
        `<option class="item-type-entry" value="" disabled hidden selected>Select an item type</option>`,
        ...ITEM_TYPES.map(type => `<option class="item-type-entry" value="${type}">${type}</option>`)
      ]
    );
  });
  
  $("select.color-name-list").each(function() {
    $(this).html(
      [
        `<option class="color-name-entry" value="" disabled hidden selected>Select a color</option>`,
        ...COLOR_NAMES.map(cname => `<option class="color-name-entry" value="${cname}">${cname}</option>`)
      ]
    );
  });

  // bind click event to form popup
  $("#form-modal").click(hidePopup);
  
  // fix cursor over popup
  $("#form-modal").on("mousemove", function(e) {
    $(this).css("cursor", e.target === this ? "pointer" : "");
  });

  $("#form-modal").on("mouseleave", function() {
    $(this).css("cursor", "");
  });

  // load content
  const contentType = location.href.includes("/found/") ? "lost" : "discovered";
  let responseData;

  try {
    responseData = await getFromDB(contentType + "_items");

    // load entry content
    for (let entry of responseData.body) {
      const colorName = entry.color_name.startsWith("Other") ? "Misc." : entry.color_name;
      const itemType = entry.item_type.startsWith("Other") ? "Misc." : entry.item_type;
      const email = entry.email_address;
      let location = entry.location_last_known;
      let date;
      if (contentType === "lost"){
        location = entry.location_last_known;
        date = new Date(entry.lost_timestamp);
      } else {
        location = entry.location;
        date = new Date(entry.found_timestamp);
      }
      const dateString = `${date.getMonth()}/${date.getDate()}/${date.getFullYear()} at ${date.getHours() % 12 || 12}${date.getHours() > 11 ? "P":"A"}M`;
      const comments = entry.comments;

      $("#entry-content").append(`
      <div class="item-entry">
        <div class="content-div">
          <h1>${colorName}</h1>
          <h1>${itemType}</h1>
          <p>${location}</p>
          <p>${dateString}</p>
          <a href="mailto:${email}">${email}</a>
          <p>${comments}</p>
        </div>
        ${entry["image_url"] ? `<div class="img-div"><img src="/user_assets/${entry['image_url']}"></div>` : ""}
        </div>
      </div>
    `);
    }
  } catch (e) {
    console.log("Unable to fetch form-data");
  }
});

/*********** end onload events ***********/
/*********** start document shortcuts ***********/

function setFieldDateToday(inputID) {
  // correct timezone dynamically from ISO string
  const now = new Date(); // current date
  const offsetNow = new Date().setHours(now.getHours() - now.getTimezoneOffset()/60); // offset the current time by the timezone
  const trimmedISO = new Date(offsetNow).toISOString().substring(0,16); // trim current ISO time to minutes

  // update HTML element
  $("#"+inputID).attr("value", trimmedISO);
}

/*********** end document shortcuts ***********/
/*********** start php/db stuff ***********/

async function getFromDB(dbName, limit=50) {
  let data;

  await $.ajax({
    url: `/php/get_db.php?limit=${limit}&table=${dbName}`,
    method: "GET",
    dataType: "json",
    success: res => data = res
  });

  return data;
}

async function postLostItem() {
  const formData = new FormData( $("#lost-form")[0] );
  let response;
  
  await $.ajax({
    url: `/php/post_lost_db.php`,
    method: "POST",
    data: formData, // extract form data
    success: res => response = res,
    processData: false,
    contentType: false
  });

  hidePopup();
  location.reload(true);
  return response;
}

async function postDiscoveredItem() {
  const formData = new FormData( $("#discovered-form")[0] );
  let response;
  
  await $.ajax({
    url: `/php/post_discovered_db.php`,
    method: "POST",
    data: formData, // extract form data
    success: res => response = res,
    error: e => console.log(e),
    processData: false,
    contentType: false
  });

  hidePopup();
  location.reload(true);
  return response;
}

/*********** end php/db stuff ***********/
/*********** start pop-up form ***********/

// show popup on DOM
function showPopup() {
  $("#form-modal").css("display", "flex");
}

// hide popups on DOM
function hidePopup(e) {
  // verify target
  if (!e || e.target === $("#form-modal")[0])
    $("#form-modal").css("display", "");
}

/*********** end pop-up form ***********/
