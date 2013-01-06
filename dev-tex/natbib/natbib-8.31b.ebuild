# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/natbib/natbib-8.31b.ebuild,v 1.3 2011/08/12 17:35:13 tomka Exp $

EAPI=3

inherit latex-package

DESCRIPTION="LaTeX package to act as generalized interface for bibliographic style files"

SRC_URI="http://www.mps.mpg.de/software/latex/localtex/zipped/natbib.zip -> ${P}.zip
	http://www.mps.mpg.de/software/latex/localtex/zipped/bibentry.zip -> ${PN}-bibentry-${PV}.zip"
HOMEPAGE="http://www.mps.mpg.de/software/latex/localtex/localltx.html#natbib"
LICENSE="LPPL-1.2"
SLOT="0"
IUSE=""

KEYWORDS="amd64 x86"
DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"

TEXMF=/usr/share/texmf-site
