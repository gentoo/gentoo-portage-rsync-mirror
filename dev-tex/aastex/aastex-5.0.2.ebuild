# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/aastex/aastex-5.0.2.ebuild,v 1.6 2010/10/19 05:47:35 leio Exp $

inherit latex-package

MY_P=${PN/latex-/}${PV//./}
S=${WORKDIR}/${MY_P}
DESCRIPTION="LaTeX package used to mark up manuscripts for American Astronomical Society journals. (AASTeX)"
HOMEPAGE="http://www.journals.uchicago.edu/AAS/AASTeX/"
SRC_URI="http://www.journals.uchicago.edu/AAS/AASTeX/${MY_P}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha hppa ~mips ppc sparc x86"
