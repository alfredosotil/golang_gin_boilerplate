-- +goose Up
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_users_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `users` VALUES (1,'2021-03-03 23:31:30','2021-03-03 23:31:30',NULL,'user1@example.com','$2y$12$5cg0So96dfKll14wrivrp.ccl/zcbtnx9Cge4UFqkvw5H89dfpSCe ','user1'),(2,'2021-03-03 23:31:30','2021-03-03 23:31:30',NULL,'user2@example.com','$2y$12$NU7se45IiQoostWNprx4Iu0nC4I5CCHDt74JMT3Lsr0FRN7wl3UZu ','user2');

CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_posts_deleted_at` (`deleted_at`),
  KEY `posts_user_id_users_id_foreign` (`user_id`),
  CONSTRAINT `posts_user_id_users_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- +goose Down
DROP TABLE `posts`;
DROP TABLE `users`;
