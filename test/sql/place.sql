INSERT INTO area (id, gid, name, type) VALUES
    (241, '89a675c2-3e37-3518-b83c-418bad59a85a', 'Europe', 1),
    (222, '489ce91b-6658-3307-9877-795b68554c98', 'United States', 1);

INSERT INTO country_area (area) VALUES (222), (241);
INSERT INTO iso_3166_1 (area, code) VALUES (222, 'US'), (241, 'XE');

INSERT INTO place (id, gid, name, type, address, area, coordinates, comment, edits_pending, last_updated, begin_date_year, begin_date_month, begin_date_day, end_date_year, end_date_month, end_date_day, ended) VALUES (1, 'df9269dd-0470-4ea2-97e8-c11e46080edd', 'A Test Place', 2, 'An Address', 241, '(0.323,1.234)', 'A PLACE!', 0, '2013-09-07 14:40:22.041309+00', 2013, NULL, NULL, NULL, NULL, NULL, '0');

INSERT INTO place_alias (id, name, sort_name, place, edits_pending)
    VALUES (1, 'A Test Alias', 'A Test Alias', 1, 0);
