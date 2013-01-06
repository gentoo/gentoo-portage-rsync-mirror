# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gshhs-data/gshhs-data-2.2.0.ebuild,v 1.1 2011/12/27 07:52:45 bicatali Exp $

EAPI=4

DESCRIPTION="Global Self-consistent, Hierarchical, High-resolution Shoreline programs data"
HOMEPAGE="http://www.ngdc.noaa.gov/mgg/shorelines/gshhs.html"
SRC_URI="http://www.ngdc.noaa.gov/mgg/shorelines/data/gshhs/version${PV}/gshhs+wdbii_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_install() {
	dodoc gshhs/README.TXT
	rm -f gshhs/README.TXT
	insinto /usr/share
	doins -r *
}
