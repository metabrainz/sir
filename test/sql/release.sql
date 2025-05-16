INSERT INTO artist (id, gid, name, sort_name)
    VALUES (1, 'a9d99e40-72d7-11de-8a39-0800200c9a66', 'Name', 'Name');

INSERT INTO artist_credit (id, name, artist_count, gid)
    VALUES (1, 'Name', 1, '949a7fd5-fe73-3e8f-922e-01ff4ca958f7');
INSERT INTO artist_credit_name (artist_credit, artist, name, position, join_phrase)
    VALUES (1, 1, 'Name', 0, '');

INSERT INTO area (id, gid, name, type) VALUES
  (221, '8a754a16-0027-3a29-b6d7-2b40ea0481ed', 'United Kingdom', 1);
INSERT INTO country_area (area) VALUES (221);
INSERT INTO iso_3166_1 (area, code) VALUES (221, 'GB');

INSERT INTO release_group (id, gid, name, artist_credit, type, comment, edits_pending)
    VALUES (1, '3b4faa80-72d9-11de-8a39-0800200c9a66', 'Arrival', 1, 1, 'Comment', 2);

INSERT INTO release (id, gid, name, artist_credit, release_group, status, packaging, language, script, barcode, comment, edits_pending) VALUES (1, 'f34c079d-374e-4436-9448-da92dedef3ce', 'Arrival', 1, 1, 1, 1, 145, 3, '731453398122', 'Comment', 2);
INSERT INTO release_country (release, country, date_year, date_month, date_day) VALUES (1, 221, 2009, 5, 8);
;

INSERT INTO release (id, gid, name, artist_credit, release_group) VALUES (2, '7a906020-72db-11de-8a39-0800200c9a66', 'Release #2', 1, 1);
;

INSERT INTO label (id, gid, name) VALUES (1, '00a23bd0-72db-11de-8a39-0800200c9a66', 'Label');

INSERT INTO release_label (id, release, label, catalog_number)
    VALUES (1, 1, 1, 'ABC-123'), (2, 1, 1, 'ABC-123-X');

INSERT INTO editor (id, name, password, privs, email, website, bio, email_confirm_date, member_since, last_login_date, ha1) VALUES (1, 'editor', '{CLEARTEXT}pass', 0, 'test@editor.org', 'http://musicbrainz.org', 'biography', '2005-10-20', '1989-07-23', now(), '3f3edade87115ce351d63f42d92a1834');
INSERT INTO annotation (id, editor, text, changelog) VALUES (1, 1, 'Annotation', 'change');
INSERT INTO release_annotation (release, annotation) VALUES (1, 1);

INSERT INTO release_gid_redirect (gid, new_id) VALUES ('71dc55d8-0fc6-41c1-94e0-85ff2404997d', 1);

INSERT INTO artist (id, gid, name, sort_name, comment)
    VALUES (2, '7a906020-72db-11de-8a39-0800200c9a66', 'Various Artists', 'Various Artists', ''),
           (3, '1a906020-72db-11de-8a39-0800200c9a66', 'Various Artists', 'Various Artists', 'Various Artists 2');
INSERT INTO artist_credit (id, name, artist_count, gid)
    VALUES (2, 'Various Artists', 1, 'c44109ce-57d7-3691-84c8-37926e3d41d2');
INSERT INTO artist_credit_name (artist_credit, artist, name, position, join_phrase) VALUES (2, 2, 'Various Artists', 1, '');

INSERT INTO release_group (id, gid, name, artist_credit)
    VALUES (2, '25b6fe30-ff5b-11de-8a39-0800200c9a66', 'Various Release', 2);
INSERT INTO release (id, gid, name, artist_credit, release_group) VALUES (3, '25b6fe30-ff5b-11de-8a39-0800200c9a66', 'Various Release', 2, 2);
;

INSERT INTO medium (id, track_count, release, position) VALUES (1, 1, 3, 1);
INSERT INTO recording (id, artist_credit, name, gid)
    VALUES (1, 2, 'Track on recording', 'b43eb990-ff5b-11de-8a39-0800200c9a66');
INSERT INTO track (id, gid, name, artist_credit, medium, position, number, recording)
    VALUES (1, '30f0fccd-602d-4fab-8d44-06536e596966', 'Track on recording', 1, 1, 1, 1, 1),
           (100, 'f9864eea-5455-4a8e-ad29-e0652cfe1452', 'Track on recording', 1, 1, 2, 2, 1);

INSERT INTO release_group (id, gid, name, artist_credit)
    VALUES (4, '329fb554-2a81-3d8a-8e22-ec2c66810019', 'Blonde on Blonde', 2);
INSERT INTO release (id, gid, name, artist_credit, release_group) VALUES (5, '538aff00-a009-4515-a064-11a6d5a502ee', 'Blonde on Blonde', 2, 4);
;

-- release_meta
UPDATE release_meta SET cover_art_presence = 'present' WHERE id IN (7, 8);
UPDATE release_meta SET cover_art_presence = 'darkened' WHERE id = 9;
