INSERT INTO artist (id, gid, name, sort_name)
    VALUES (1, '945c079d-374e-4436-9448-da92dedef3cf', 'Artist', 'Artist');

INSERT INTO artist_credit (id, name, artist_count, gid)
    VALUES (1, 'Artist', 1, '949a7fd5-fe73-3e8f-922e-01ff4ca958f7');
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase)
    VALUES (1, 0, 1, 'Artist', '');

INSERT INTO recording (id, gid, name, artist_credit, length)
    VALUES (1, '54b9d183-7dab-42ba-94a3-7388a66604b8', 'King of the Mountain', 1, 293720),
           (2, '659f405b-b4ee-4033-868a-0daa27784b89', 'π', 1, 369680),
           (3, 'ae674299-2824-4500-9516-653ac1bc6f80', 'Bertie', 1, 258839),
           (4, 'b1d58a57-a0f3-4db8-aa94-868cdc7bc3bb', 'Mrs. Bartolozzi', 1, 358960),
           (5, '44f52946-0c98-47ba-ba60-964774db56f0', 'How to Be Invisible', 1, 332613),
           (6, '07614140-8bb8-4db9-9dcc-0917c3a8471b', 'Joanni', 1, 296160);

INSERT INTO release_group (id, gid, name, artist_credit, type) VALUES (1, '7c3218d7-75e0-4e8c-971f-f097b6c308c5', 'Aerial', 1, 1);

INSERT INTO release (id, gid, name, artist_credit, release_group)
    VALUES (1, 'f205627f-b70a-409d-adbe-66289b614e80', 'Aerial', 1, 1),
           (2, '9b3d9383-3d2a-417f-bfbb-56f7c15f075b', 'Aerial', 1, 1),
           (3, 'ab3d9383-3d2a-417f-bfbb-56f7c15f075b', 'Aerial', 1, 1);

INSERT INTO release_unknown_country (release, date_year)
VALUES (1, 2007), (2, 2008);

INSERT INTO medium_format (id, gid, name, has_discids) VALUES (123465, '52014420-cae8-11de-8a39-0800200c9a26', 'Format', TRUE);
INSERT INTO medium (id, release, position, format, name) VALUES (1, 1, 1, 123465, 'A Sea of Honey');
INSERT INTO medium (id, release, position, format, name) VALUES (2, 1, 2, 123465, 'A Sky of Honey');

INSERT INTO track (id, gid, medium, position, number, recording, name, artist_credit, length)
    VALUES (1, '66c2ebff-86a8-4e12-a9a2-1650fb97d9d8', 1, 1, 1, 1, 'King of the Mountain', 1, NULL),
           (2, 'b0caa7d1-0d1e-483e-b22b-ec6ab7fada06', 1, 2, 2, 2, 'π', 1, 369680),
           (3, 'f891acda-39d6-4a7f-a9d1-dd87b7c46a0a', 1, 3, 3, 3, 'Bertie', 1, 258839);

INSERT INTO track (id, gid, medium, position, number, recording, name, artist_credit, length)
    VALUES (4, '6c04d03c-4995-43be-8530-215ca911dcbf', 1, 4, 4, 4, 'Mrs. Bartolozzi', 1, 358960),
           (5, '849dc232-c33a-4611-a6a5-5a0969d63422', 1, 5, 5, 5, 'How to Be Invisible', 1, 332613);

INSERT INTO link (id, link_type, attribute_count, begin_date_year, begin_date_month, begin_date_day, end_date_year, end_date_month, end_date_day, ended)
       VALUES (1, 151, 0, 1971, 2, NULL, 1972, 2, NULL, true);

INSERT INTO l_artist_recording (id, link, entity0, entity1) VALUES (1, 1, 1, 1);
INSERT INTO l_artist_recording (id, link, entity0, entity1) VALUES (2, 1, 1, 2);

INSERT INTO artist (id, gid, name, sort_name)
    VALUES (100, '5f9913b0-7219-11de-8a39-0800200c9a66', 'Kate Bush', 'Kate Bush');

INSERT INTO artist_credit (id, name, artist_count, gid)
    VALUES (100, 'Kate Bush', 1, '922e7fd5-3e8f-fe73-949a-01ff4ca958f7');
INSERT INTO artist_credit_name (artist_credit, position, artist, name)
    VALUES (100, 0, 100, 'Kate Bush');

INSERT INTO release_group (id, gid, name, artist_credit) VALUES
    (100, '3ca028a0-3c88-43cc-943d-d9ce1bade7a7', 'Aerial', 1);
INSERT INTO release (id, gid, name, release_group, artist_credit) VALUES
    (100, '8c2a1f4e-e11a-4261-a0f4-d1039ef94745', 'Aerial', 1, 1),
    (200, '37b58375-019f-4ffb-8360-9c4b11d087b8', 'Aerial', 1, 1);
INSERT INTO medium (id, release, track_count, position) VALUES (100, 100, 5, 1),  (200, 200, 3, 2);

INSERT INTO cdtoc (id, discid, freedb_id, track_count, leadout_offset, track_offset) VALUES
    (1, 'tLGBAiCflG8ZI6lFcOt87vXjEcI-', '5908ea07', 7, 171327,
     ARRAY[150,22179,49905,69318,96240,121186,143398]);
INSERT INTO medium_cdtoc (id, medium, cdtoc) VALUES
    (1, 100, 1), (2, 200, 1);

INSERT INTO recording (id, gid, name, artist_credit, length)
VALUES (100, '66c2ebff-94a3-42ba-7dab-7388a66604b8', 'The same track over and over', 1, NULL);
INSERT INTO track (id, gid, medium, position, number, recording, name, artist_credit, length)
VALUES (100, '66c2ebff-8530-4e12-a9a2-1650fb97d9d8', 100, 1, 1, 100, 'The same track over and over', 100, NULL),
       (101, '54b9d183-0d1e-483e-c33c-ec6ab7fada06', 100, 2, 2, 100, 'The same track over and over', 100, NULL),
       (102, 'f891acda-a9d1-7c28-39d6-dd87b7c46a0a', 100, 3, 3, 100, 'The same track over and over', 100, NULL),
       (103, '6c04d03c-4995-43be-86a8-215ca911dcbf', 100, 4, 4, 100, 'The same track over and over', 100, NULL),
       (104, '849dc232-c33a-b7da-a6a5-5a0969d63422', 100, 5, 5, 100, 'The same track over and over', 100, NULL),
       (105, '72469a76-7c28-8844-b7da-174c1034cd0a', 200, 1, 6, 100, 'The same track over and over', 100, NULL),
       (106, '5d54de57-561d-cafe-9ced-af4327249d66', 200, 2, 7, 100, 'The same track over and over', 100, NULL),
       (107, 'c05b1c9a-e768-6543-b2b6-c687060c8f1e', 200, 3, 1, 100, 'The same track over and over', 100, NULL);
