# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdiscid/libdiscid-0.6.1.ebuild,v 1.1 2013/10/04 08:20:45 radhermit Exp $

EAPI=5

inherit autotools-utils

DESCRIPTION="Client library to create MusicBrainz enabled tagging applications"
HOMEPAGE="http://musicbrainz.org/doc/libdiscid"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="static-libs"

DOCS=( AUTHORS ChangeLog examples/discid.c README )
