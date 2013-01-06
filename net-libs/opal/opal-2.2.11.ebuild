# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/opal/opal-2.2.11.ebuild,v 1.9 2010/07/20 18:41:58 jer Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="OPAL library, used by Ekiga"
HOMEPAGE="http://www.ekiga.org"
SRC_URI="http://www.ekiga.org/admin/downloads/latest/sources/sources/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="novideo noaudio debug"

RDEPEND="~dev-libs/pwlib-1.10.$((${PV##*.}-1))
	>=media-video/ffmpeg-0.4.7"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# Makefile is currently broken with NOTRACE=1, fix that
	epatch "${FILESDIR}"/${PN}-2.1.1-notrace.diff
}

src_compile() {
	tc-export CC CXX
	local makeopts
	local myconf

	# remove -fstack-protector, may cause problems (bug #75259)
	filter-flags -fstack-protector

	# NOTRACE avoid compilation problems, we disable PTRACING using NOTRACE=1
	# compile with PTRACING if the user wants to debug stuff
	if ! use debug; then
		makeopts="${makeopts} NOTRACE=1"
	fi

	# doesn't work with osptoolkit-3.3.1
	# iax2 support is missing in the tarball, disable it too
	myconf="--disable-transnexusosp --disable-iax --enable-localspeex"

	use novideo \
		&& myconf="${myconf} --disable-video"

	use noaudio \
		&& myconf="${myconf} --disable-audio"

	econf \
		PWLIBDIR=/usr/share/pwlib \
		OPALDIR="${S}" \
		${myconf} || die "configure failed"

	emake ${makeopts} opt || die "make failed"
}

src_install() {
	local OPAL_ARCH ALT_ARCH OPAL_SUFFIX
	local makeopts libdir libname

	# make NOTRACE=1 opt ==> linux_$ARCH_n
	# make opt           ==> linux_$ARCH_r
	if ! use debug; then
		OPAL_SUFFIX="n"
		makeopts="NOTRACE=1"
	else
		OPAL_SUFFIX="r"
	fi

	# use ptlib-config to get the right values here (for hppa, amd64 ...)
	OPAL_ARCH="$(ptlib-config --ostype)_$(ptlib-config --machtype)_${OPAL_SUFFIX}"

	# set ALT_ARCH
	if use debug; then
		ALT_ARCH=${OPAL_ARCH/_r/_n}
	else
		ALT_ARCH=${OPAL_ARCH/_n/_r}
	fi

	###
	# Install stuff
	#
	make PREFIX=/usr DESTDIR="${D}" \
		${makeopts} install || die "install failed"

	libdir=$(get_libdir)
	libname="libopal_${OPAL_ARCH}.so.${PV}"

	# compat symlinks
	for pv in ${PV} ${PV%.[0-9]} ${PV%.[0-9]*.[0-9]}; do
		dosym ${libname} /usr/${libdir}/libopal_${ALT_ARCH}.so.${pv}
	done
	dosym ${libname} /usr/${libdir}/libopal_${OPAL_ARCH}.so
	dosym ${libname} /usr/${libdir}/libopal_${ALT_ARCH}.so

	###
	# Compatibility "hacks"
	#

	# install version.h into $OPALDIR
	insinto /usr/share/opal
	doins version.h
}
