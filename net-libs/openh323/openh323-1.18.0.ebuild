# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.18.0.ebuild,v 1.12 2012/10/05 19:12:21 ago Exp $

EAPI=4

inherit eutils flag-o-matic multilib toolchain-funcs

MY_P="${PN}-v${PV//./_}"

DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing protocol"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.voxgratia.org/releases/${PN}-v${PV//./_}-src-tar.gz"

IUSE="debug ssl +video +audio"
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="alpha amd64 ~hppa ppc sparc x86"

DEPEND=">=sys-apps/sed-4
	=dev-libs/pwlib-1.10*
	virtual/ffmpeg
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}_v${PV//./_}"

pkg_setup() {
	use debug || makeopts="NOTRACE=1"
}

src_unpack() {
	tar -xzf "${DISTDIR}"/${A} -C "${WORKDIR}" || die
}

src_prepare() {
	# Makefile does not work correctly, fix
	epatch "${FILESDIR}"/${PN}-1.18.0-install.diff
	# Do not include compiler.h, bug #168791
	epatch "${FILESDIR}"/${P}-compilerh.patch
}

src_configure() {
	# remove -fstack-protector, may cause problems (bug #75259)
	filter-flags -fstack-protector

	#export OPENH323DIR=${S}

	econf \
		$(use_enable video) \
		$(use_enable audio) \
		--disable-transnexusosp
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" \
		${makeopts} opt
}

src_install() {
	emake ${makeopts} PREFIX=/usr DESTDIR="${D}" install

	###
	# Compatibility "hacks"
	#

	# debug / no debug use different suffixes - some packages build with only one
	for i in "${ED}"/usr/lib/libh323_linux_x86_*; do
		use debug && ln -s "${ED}"/usr/lib/libh323_linux_x86_*.so.*.*.* ${i/_r/_n} \
			|| ln -s "${ED}"/usr/lib/libh323_linux_x86_*.so.*.*.* ${i/_n/_r}
	done

	# set notrace corerctly
	if ! use debug ; then
		sed \
			-i \
			-e "s:^\(NOTRACE.*\):\1 1:" \
			"${ED}"/usr/share/openh323/openh323u.mak || die
	fi

	# mod to keep gnugk happy
	insinto /usr/share/openh323/src
	echo -e "opt:\n\t:" > "${T}"/Makefile
	doins "${T}"/Makefile

	# these should point to the right directories,
	# openh323.org apps and others need this
	sed -i -e "s:^OH323_LIBDIR = \$(OPENH323DIR).*:OH323_LIBDIR = /usr/${libdir}:" \
		"${ED}"/usr/share/openh323/openh323u.mak || die
	sed -i -e "s:^OH323_INCDIR = \$(OPENH323DIR).*:OH323_INCDIR = /usr/include/openh323:" \
		"${ED}"/usr/share/openh323/openh323u.mak || die

	# this is hardcoded now?
	sed -i -e "s:^\(OPENH323DIR[ \t]\+=\) "${S}":\1 /usr/share/openh323:" \
		"${ED}"/usr/share/openh323/openh323u.mak || die
}
