# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbibtex/kbibtex-0.5.ebuild,v 1.1 2014/03/13 21:42:45 johu Exp $

EAPI=5

inherit versionator kde4-base

DESCRIPTION="BibTeX editor for KDE to edit bibliographies used with LaTeX"
HOMEPAGE="http://home.gna.org/kbibtex/"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://download.gna.org/${PN}/$(get_version_component_range 1-2)/${P/_/-}.tar.xz"
	KEYWORDS="~amd64 ~x86"
else
	ESVN_REPO_URI="svn://svn.gna.org/svn/${PN}/trunk"
	ESVN_PROJECT="${PN}"
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	app-text/poppler[qt4]
	dev-libs/libxml2
	dev-libs/libxslt
	virtual/tex-base
"
RDEPEND="${DEPEND}
	dev-tex/bibtex2html"

PATCHES=( "${FILESDIR}/${P}-build-fix.patch" )

S=${WORKDIR}/${P/_/-}
