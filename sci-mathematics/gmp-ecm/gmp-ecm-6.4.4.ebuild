# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gmp-ecm/gmp-ecm-6.4.4.ebuild,v 1.2 2013/03/07 08:05:21 jlec Exp $

EAPI=5

DESCRIPTION="Elliptic Curve Method for Integer Factorization"
HOMEPAGE="http://ecm.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/32159/${P}.tar.gz"

inherit eutils flag-o-matic

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+blas +custom-tune gwnum -openmp test"

DEPEND="
	dev-libs/gmp
	blas? ( sci-libs/gsl )
	gwnum? ( sci-mathematics/gwnum )
	openmp? ( sys-devel/gcc[openmp] )"
RDEPEND="${DEPEND}"

# can't be both enabled
REQUIRED_USE="gwnum? ( !openmp )"

S=${WORKDIR}/ecm-${PV}

MAKEOPTS+=" -j1"

src_configure() {
	if use gwnum; then myconf="--with-gwnum=/usr/lib"; fi
	# --enable-shellcmd is broken
	econf $(use_enable openmp) $myconf
}

src_compile() {
	append-ldflags "-Wl,-z,noexecstack"
	if use custom-tune; then
		use amd64 && cd x86_64
		use x86 && cd pentium4
		emake
		cd .. && make bench_mulredc || die
		sed -i -e 's:#define TUNE_MULREDC_TABLE://#define TUNE_MULREDC_TABLE:g' `readlink ecm-params.h` || die
		sed -i -e 's:#define TUNE_SQRREDC_TABLE://#define TUNE_SQRREDC_TABLE:g' `readlink ecm-params.h` || die
		./bench_mulredc | tail -n 4 >> `readlink ecm-params.h` || die
	fi
	default
}

src_install() {
	default
	mkdir -p "${D}/usr/include/${PN}/"
	cp "${S}"/*.h "${D}/usr/include/${PN}" || die "Failed to copy headers" # needed by other apps like YAFU
}
