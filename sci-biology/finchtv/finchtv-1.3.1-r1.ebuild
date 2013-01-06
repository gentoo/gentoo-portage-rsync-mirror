# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/finchtv/finchtv-1.3.1-r1.ebuild,v 1.5 2012/07/24 12:22:42 jlec Exp $

MY_PV="${PV//./_}"
MY_P=${PN}_${MY_PV}

DESCRIPTION="Graphical viewer for chromatogram files"
HOMEPAGE="http://www.geospiza.com/finchtv/"
SRC_URI="http://www.geospiza.com/finchtv/download/programs/linux/${MY_P}.tar.gz"

LICENSE="finchtv"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_P}"

QA_PREBUILT="opt/bin/*"

src_install() {
	exeinto /opt/bin
	doexe finchtv || die "Failed to install executable"
	dodoc License.txt ReleaseNotes.txt \
		|| die "Failed to install docs"
	dohtml -r Help/* \
		|| die "Failed to install html docs"
	insinto /usr/share/doc/${PF}/
	doins -r SampleData \
		|| die "Failed to move SampleData"

}
