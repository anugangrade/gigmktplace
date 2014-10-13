# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create!(email: 'admin@bytelogistics.com', password: 'bytelogistics', password_confirmation: 'bytelogistics')


Category.create([
	{title:"Graphics & Design", category_url:"graphics-design"},
	{title:"Online Marketing", category_url:"online-marketing"},
	{title:"Writing & Translation", category_url:"writing-translation"},
	{title:"Video & Animation", category_url:"video-animation"},
	{title:"Music & Audio", category_url:"music-audio"},
	{title:"Programming & Tech", category_url:"programming-tech"},
	{title:"Gifts", category_url: "gifts"}
])


SubCategory.create ([
	{category_id: 1, title:"Cartoons & Caricatures", subcategory_url: "cartoons-caricatures"},
	{category_id: 1, title:"Logo Design", subcategory_url: "logo-design"},
	{category_id: 1, title:"Illustration", subcategory_url: "illustration"},
	{category_id: 1, title:"Ebook Covers & Packages", subcategory_url: "ebook-covers-packages"},
	{category_id: 1, title:"Web Design & UI", subcategory_url: "web-design-ui"},
	{category_id: 1, title:"Photography & Photoshopping", subcategory_url: "photography-photoshopping"},
	{category_id: 1, title:"Presentation Design", subcategory_url: "presentation-design"},
	{category_id: 1, title:"Flyers & Brochures ", subcategory_url: "flyers-brochures"},
	{category_id: 1, title:"Business Cards", subcategory_url: "business-cards"},
	{category_id: 1, title:"Banners & Headers", subcategory_url: "banners-headers"},
	{category_id: 1, title:"Architecture", subcategory_url: "architecture"},
	{category_id: 1, title:"Landing Pages", subcategory_url: "landing-pages"},
	{category_id: 1, title:"Other", subcategory_url: "other"},

	{category_id: 2, title:"Web Analytics", subcategory_url: "web-analytics"},
	{category_id: 2, title:"Article & PR Submission", subcategory_url: "article-pr-submitssion"},
	{category_id: 2, title:"Blog Mentions", subcategory_url: "blog-mentions"},
	{category_id: 2, title:"Domain Research", subcategory_url: "domain-research"},
	{category_id: 2, title:"Fan Pages", subcategory_url: "fan-pages"},
	{category_id: 2, title:"Keywords Research", subcategory_url: "keyword-research"},
	{category_id: 2, title:"SEO", subcategory_url: "seo"},
	{category_id: 2, title:"Bookmarking & Links", subcategory_url: "bookmarking-links"},
	{category_id: 2, title:"Social Marketing", subcategory_url: "social-marketing"},
	{category_id: 2, title:"Get Traffic", subcategory_url: "get-traffic"},
	{category_id: 2, title:"Video Marketing", subcategory_url: "video-marketing"},
	{category_id: 2, title:"Other", subcategory_url: "other"},

	{category_id: 3, title:"Copywriting", subcategory_url: "copywriting"},
	{category_id: 3, title:"SEO Keyword Optimization", subcategory_url: "seo-keyword-optimization"},
	{category_id: 3, title:"Creative Writing & Scripting", subcategory_url: "creattive-writing-scripting"},
	{category_id: 3, title:"Translation", subcategory_url: "translation"},
	{category_id: 3, title:"Transcripts", subcategory_url: "transcripts"},
	{category_id: 3, title:"Website Content", subcategory_url: "website-content"},
	{category_id: 3, title:"Reviews", subcategory_url: "reviews"},
	{category_id: 3, title:"Resumes & Cover Letters", subcategory_url: "resumes-cover-letters"},
	{category_id: 3, title:"Speech Writing", subcategory_url: "speech-writing"},
	{category_id: 3, title:"Proofreading & Editing", subcategory_url: "proofreading-editing"},
	{category_id: 3, title:"Press Releases", subcategory_url: "press-releases"},
	{category_id: 3, title:"Other", subcategory_url: "other"},

	{category_id: 4, title:"Commercials", subcategory_url: "commercials"},
	{category_id: 4, title:"Editing & Post Production", subcategory_url: "editing-post-production"},
	{category_id: 4, title:"Animation & 3D", subcategory_url: "animation-3d"},
	{category_id: 4, title:"Testimonials & Reviews by Actors", subcategory_url: "testimonials-reviews-by-actors"},
	{category_id: 4, title:"Puppets", subcategory_url: "puppets"},
	{category_id: 4, title:"Stop Motion", subcategory_url: "stop-motion"},
	{category_id: 4, title:"Intros", subcategory_url: "intros"},
	{category_id: 4, title:"Other", subcategory_url: "other"},

	{category_id: 5, title:"Audio Editing & Mastering", subcategory_url: "audio-editing-mastering"},
	{category_id: 5, title:"Jingles", subcategory_url: "jingles"},
	{category_id: 5, title:"Songwriting", subcategory_url: "songwriting"},
	{category_id: 5, title:"Music Lessons", subcategory_url: "music-lessons"},
	{category_id: 5, title:"Rap Music", subcategory_url: "rap-music"},
	{category_id: 5, title:"Hip-Hop Music", subcategory_url: "hip-hop-music"},
	{category_id: 5, title:"Narration & Voice-Over", subcategory_url: "narration-voice-over"},
	{category_id: 5, title:"Sound Effects & Loops", subcategory_url: "sound-effects-loops"},
	{category_id: 5, title:"Custom Ringtones", subcategory_url: "custom-ringtones"},
	{category_id: 5, title:"Voicemail Greetings", subcategory_url: "voicemail-greetings"},
	{category_id: 5, title:"Custom Songs", subcategory_url: "custom-songs"},
	{category_id: 5, title:"Other", subcategory_url: "other"},

	{category_id: 6, title:".Net", subcategory_url: "dot-net"},
	{category_id: 6, title:"C++", subcategory_url: "c++"},
	{category_id: 6, title:"CSS & HTML", subcategory_url: "css-html"},
	{category_id: 6, title:"Joomla & Drupal", subcategory_url: "joomle-drupal"},
	{category_id: 6, title:"Databases", subcategory_url: "databases"},
	{category_id: 6, title:"Java", subcategory_url: "java"},
	{category_id: 6, title:"JavaScript", subcategory_url: "javascript"},
	{category_id: 6, title:"PSD to HTML", subcategory_url: "psd-to-html"},
	{category_id: 6, title:"WordPress", subcategory_url: "wordpress"},
	{category_id: 6, title:"Flash", subcategory_url: "flash"},
	{category_id: 6, title:"iOS, Android & Mobile", subcategory_url: "ios-android-mobile"},
	{category_id: 6, title:"PHP", subcategory_url: "php"},
	{category_id: 6, title:"QA & Software Testing", subcategory_url: "qa-software-testing"},
	{category_id: 6, title:"Technology", subcategory_url: "technology"},
	{category_id: 6, title:"Other", subcategory_url: "other"},

	{category_id: 7, title:"Greeting Cards", subcategory_url: "greeting-cards"},
	{category_id: 7, title:"Video Greetings", subcategory_url: "voice-greetings"},
	{category_id: 7, title:"Unusual Gifts", subcategory_url: "unusual-gifts"},
	{category_id: 7, title:"Arts & Crafts", subcategory_url: "arts-crafts"},
	{category_id: 7, title:"Handmade Jewelry", subcategory_url: "handsome-jewelry"},
	{category_id: 7, title:"Gifts for Geeks", subcategory_url: "gifts-for-geeks"},
	{category_id: 7, title:"Postcards From...", subcategory_url: "postcadrs-from"},
	{category_id: 7, title:"Recycled Crafts", subcategory_url: "recycled-crafts"},
	{category_id: 7, title:"Other", subcategory_url: "other"}


])