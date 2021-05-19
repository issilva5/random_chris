import React, { useState, useEffect } from 'react';
import chris from '../../chris.json'
import Badge from 'react-bootstrap/Badge';
import './content.css'

function Content() {
    const [episodeTitle, setEpisodeTitle] = useState("");
    const [episodeDescription, setEpisodeDescription] = useState("");
    const [episodeSeason, setEpisodeSeason] = useState(-1);
    const [episodeNumber, setEpisodeNumber] = useState(-1);

    useEffect(() => {

        const aux = chris.episodes[Math.floor(Math.random() * chris.episodes.length)]
        setEpisodeTitle(aux.TITLE)
        setEpisodeDescription(aux.DESCRIPTION)
        setEpisodeSeason(aux.SEASON)
        setEpisodeNumber(aux.NUMBER)

    }, [])


    return (
        <div className="container" id="conteudo">
            <h1>{episodeTitle} <Badge variant="secondary" id="episode-badge">S{episodeSeason}E{episodeNumber}</Badge> </h1>
            <p className="text-justify">{episodeDescription}</p>
        </div>
    )

}

export default Content