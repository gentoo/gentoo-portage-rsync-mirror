# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/natbib/natbib-8.31a-r1.ebuild,v 1.1 2010/10/02 17:31:15 dilfridge Exp $

inherit latex-package

DESCRIPTION="LaTeX package to act as generalized interface for bibliographic style files"

SRC_URI="mirror://gentoo/${P}.zip"
HOMEPAGE="http://tug.ctan.org/cgi-bin/ctanPackageInformation.py?id=natbib"
LICENSE="LPPL-1.2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${PN}"

TEXMF=/usr/share/texmf-site
