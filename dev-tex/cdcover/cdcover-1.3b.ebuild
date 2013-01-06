# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/cdcover/cdcover-1.3b.ebuild,v 1.7 2007/02/06 16:40:59 nattfodd Exp $

inherit latex-package

S=${WORKDIR}/cdcover
DESCRIPTION="LaTeX package used to create CD case covers."
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/cd-cover/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc"
IUSE=""

# checksum from official ftp site changes frequently so we mirror it
