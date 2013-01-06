# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/allpathslg/allpathslg-37578.ebuild,v 1.6 2012/12/14 09:57:17 ulm Exp $

EAPI="2"

inherit autotools flag-o-matic

DESCRIPTION="De novo assembly of whole-genome shotgun microreads"
HOMEPAGE="http://www.broadinstitute.org/science/programs/genome-biology/crd"
SRC_URI="ftp://ftp.broadinstitute.org/pub/crd/ALLPATHS/Release-LG/latest_source_code/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="amd64"

DEPEND="
	dev-libs/boost
	!sci-biology/allpaths
	sci-biology/vaal"
RDEPEND=""

src_prepare() {
	filter-ldflags -Wl,--as-needed
	sed -i 's/-ggdb3//' configure.ac || die
	eautoreconf
}

src_install() {
	einstall || die
	# Provided by sci-biology/vaal
	for i in QueryLookupTable ScaffoldAccuracy MakeLookupTable Fastb ShortQueryLookup; do
		rm "${D}/usr/bin/$i" || die
	done
}
