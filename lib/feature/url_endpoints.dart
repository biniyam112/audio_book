const baseUrl = 'http://www.marakigebeya.com.et';

const podcastUrl = '$baseUrl/api/podcast?limit=10';
const subscribeForPodcastUrl = "$baseUrl/api/SubscribeForPodcast";
const mySubscriptions = "$baseUrl/api/MySubscriptions";
const podcastEpisodes = "$baseUrl/api/Episodes";
const  unsubscribePodcastEndpoint="$baseUrl/api/SubscribeForPodcast/Unsubscribe";
const podcastCommentEndpoint='$baseUrl/api/Comments';
const podcastCommentGetEndpoint ='$podcastCommentEndpoint/GetAllComments?Limit=10';