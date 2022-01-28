select *, sum(playCnt) from play p left join song s on p.songIdx = s.idx where isFile = 1 group by p.songIdx order by sum(playCnt) desc limit 5;

select songIdx from play where userIdx = 9 order by playCnt desc;

update chart set isFile = 1 where title = '그 사람' and artist = '이승철';