INSERT INTO artist (id, gid, name, sort_name)
    VALUES (1, 'a9d99e40-72d7-11de-8a39-0800200c9a66', 'Name', 1);

INSERT INTO artist_credit (id, name, artist_count, gid)
    VALUES (1, 'Name', 1, '949a7fd5-fe73-3e8f-922e-01ff4ca958f7');
INSERT INTO artist_credit_name (artist_credit, artist, name, position, join_phrase)
    VALUES (1, 1, 'Name', 0, '');

INSERT INTO release_group (id, gid, name, artist_credit, type, comment, edits_pending)
    VALUES (1, '7b5d22d0-72d7-11de-8a39-0800200c9a66', 'Release Group', 1, 1, 'Comment', 2);

INSERT INTO release_group (id, gid, name, artist_credit, type, comment, edits_pending)
    VALUES (2, '3b4faa80-72d9-11de-8a39-0800200c9a66', 'Release Name', 1, 1, 'Comment', 2);

INSERT INTO release (id, gid, name, artist_credit, release_group)
    VALUES (1, '4c767e70-72d8-11de-8a39-0800200c9a66', 'Release Name', 1, 1);

INSERT INTO editor (id, name, password, ha1) VALUES (1, 'editor', '{CLEARTEXT}pass', '3f3edade87115ce351d63f42d92a1834');
INSERT INTO annotation (id, editor, text, changelog) VALUES (1, 1, 'Annotation', 'change');
INSERT INTO release_group_annotation (release_group, annotation) VALUES (1, 1);

INSERT INTO release_group_gid_redirect (gid, new_id) VALUES ('77637e8c-be66-46ea-87b3-73addc722fc9', 1);

INSERT INTO artist (id, gid, name, sort_name)
    VALUES (2, '7a906020-72db-11de-8a39-0800200c9a66', 'Various Artists', 'Various Artists');
INSERT INTO artist_credit (id, name, artist_count, gid)
    VALUES (2, 'Various Artists', 1, 'c44109ce-57d7-3691-84c8-37926e3d41d2');
INSERT INTO artist_credit_name (artist_credit, artist, name, position, join_phrase) VALUES (2, 2, 'Various Artists', 1, '');

INSERT INTO release_group (id, gid, name, artist_credit)
    VALUES (3, '25b6fe30-ff5b-11de-8a39-0800200c9a66', 'Various Release', 2);
INSERT INTO release (id, gid, name, artist_credit, release_group)
    VALUES (3, '25b6fe30-ff5b-11de-8a39-0800200c9a66', 'Various Release', 2, 3);

INSERT INTO medium (id, track_count, release, position) VALUES (1, 0, 3, 1);
INSERT INTO recording (id, artist_credit, name, gid)
    VALUES (1, 2, 'Track on recording', 'b43eb990-ff5b-11de-8a39-0800200c9a66');
INSERT INTO track (id, gid, name, artist_credit, medium, position, number, recording)
    VALUES (1, '899aaf2a-a18d-4ed5-9c18-03485df72793', 'Track on recording', 1, 1, 1, 1, 1);
