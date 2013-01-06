# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/ltp/ltp-20120903.ebuild,v 1.2 2012/11/06 19:26:43 mr_bones_ Exp $

EAPI="4"

inherit autotools eutils

MY_PN="${PN}-full"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A testsuite for the linux kernel"
HOMEPAGE="http://ltp.sourceforge.net/"
SRC_URI="mirror://sourceforge/ltp/LTP%20Source/${P}/${MY_P}.bz2 -> ${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="expect perl pm open-posix python rt"

DEPEND="expect? ( dev-tcltk/expect )
	perl? ( dev-lang/perl )
	python? ( dev-lang/python )"

RESTRICT="test"

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	# Don't create groups
	export CREATE=0
}

src_prepare() {
	# regenerate
	AT_M4DIR="m4" eautoreconf
	# Create output/ and results/ directories
	# in /tmp. We don't want to pollute the libexec
	# directory
	epatch "${FILESDIR}"/runltp-path.patch
}

src_configure() {
	# FIXME: improve me
	local myconf=
	use open-posix && myconf+="--with open-posix-testsuite "
	use pm && mytconf+="--with-power-management-testsuite "
	use rt && myconf+="--with-realtime-testsuite "
	use perl && myconf+="--with-perl "
	use python && myconf+="--with-python "
	use expect && myconf+="--with-expect "

	# Better put it into /usr/libexec as everything needs to
	# be under the same directory..

	econf --prefix=/usr/libexec/${PN} ${myconf}
}

src_compile() {
	# Posix testsuite does not seem to build with -j>1
	# Is this maintained anymore?
	if use open-posix; then
		export MAKEOPTS="-j1"
	fi
	emake
}

src_install() {
	default
	dosym /usr/libexec/${PN}/runltp /usr/bin/runltp
	# install docs
	dodoc doc/MaintNotes
	for txt in doc/*.txt; do
		dodoc ${txt}
	done
	dodoc -r doc/examples doc/testcases
	dohtml -r doc/automation-*.html
	doman doc/man1/*.1
	doman doc/man3/*.3
}

pkg_postinst() {
	elog
	elog "LTP requires root access to run the tests."
	elog "The LTP root directory is located in /usr/libexec/${PN}"
	elog "but the results and output folders will be created in /tmp."
	elog "For more information please read the ltp-howto"
	elog "located in /usr/share/doc/${PF}"
	elog
}
