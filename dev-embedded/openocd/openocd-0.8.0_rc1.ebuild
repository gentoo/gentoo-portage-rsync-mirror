# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/openocd/openocd-0.8.0_rc1.ebuild,v 1.1 2014/04/06 16:02:36 hwoarang Exp $

EAPI="5"

inherit eutils multilib flag-o-matic toolchain-funcs

# One ebuild to rule them all
if [[ ${PV} == "9999" ]] ; then
	inherit autotools git-2
	KEYWORDS=""
	EGIT_REPO_URI="git://git.code.sf.net/p/${PN}/code"
else
	MY_PV="${PV/_/-}"
	MY_P="${PN}-${MY_PV}"
	S="${WORKDIR}"/${MY_P}
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${MY_PV}/${MY_P}.tar.gz"
fi

DESCRIPTION="OpenOCD - Open On-Chip Debugger"
HOMEPAGE="http://openocd.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
IUSE="blaster dummy ftdi minidriver parport presto segger +usb versaloon verbose-io"
RESTRICT="strip" # includes non-native binaries

# versaloon needs libusb:0 but the rest of the devices need libusb:1
# Therefore, treat versaloon as a special case and always pull libusb:1
# so most of the devices are supported by default.
DEPEND=">=dev-lang/jimtcl-0.73
	usb? (
		versaloon? ( virtual/libusb:0 )
		virtual/libusb:1
	)
	ftdi? ( dev-embedded/libftdi )"

RDEPEND="${DEPEND}"

REQUIRED_USE="blaster? ( ftdi ) presto? ( ftdi ) versaloon? ( usb )"

src_prepare() {
	epatch_user

	if [[ ${PV} == "9999" ]] ; then
		sed -i -e "/@include version.texi/d" doc/${PN}.texi || die
		AT_NO_RECURSIVE=yes eautoreconf
	fi

	# Disable craptastic build settings.
	sed -i \
		-e 's:if test "[$]OCDxprefix" != "[$]ac_default_prefix":if false:' \
		configure || die

	if use ftdi ; then
		local pc="libftdi$(has_version '=dev-embedded/libftdi-1*' && echo 1)"
		# Use libftdi-1 paths #460916
		local libs=$($(tc-getPKG_CONFIG) --libs ${pc})
		sed -i \
			-e "s:-lftdi -lusb:${libs}:" \
			configure src/Makefile.in || die
		append-cppflags $($(tc-getPKG_CONFIG) --cflags ${pc})
	fi
}

src_configure() {
	# Here are some defaults
	local myconf=(
		--enable-buspirate
		--enable-ioutil
		--disable-werror
		--disable-internal-jimtcl
		--enable-amtjtagaccel
		--enable-ep93xx
		--enable-at91rm9200
		--enable-gw16012
		--enable-oocd_trace
		--enable-arm-jtag-ew
	)

	# Adapters requiring usb/libusb-1.X support
	if use usb; then
		myconf+=(
			--enable-aice
			--enable-ti-icdi
			--enable-ulink
			--enable-osbdm
			--enable-opendous
			--enable-usbprog
			--enable-jlink
			--enable-rlink
			--enable-stlink
			--enable-vsllink
			--enable-arm-jtag-ew
			$(use_enable verbose-io verbose-usb-io)
			$(use_enable verbose-io verbose_usb_comms)
		)
	else
		myconf+=(
			--disable-aice
			--disable-stlink
			--disable-ti-icdi
			--disable-ulink
			--disable-osbdm
			--disable-opendous
		)
	fi

	if use blaster; then
		myconf+=(
			--enable-usb_blaster_libftdi
			--enable-usb-blaster-2
		)
	else
		myconf+=(
			--disable-usb_blaster_libftdi
			--disable-usb-blaster-2
		)
	fi

	econf \
		$(use_enable dummy) \
		$(use_enable ftdi) \
		$(use_enable minidriver minidriver-dummy) \
		$(use_enable parport) \
		$(use_enable parport parport_ppdev) \
		$(use_enable parport parport_giveio) \
		$(use_enable presto presto_libftdi) \
		$(use_enable segger jlink) \
		$(use_enable versaloon vsllink) \
		$(use_enable verbose-io verbose-jtag-io) \
		"${myconf[@]}"
}

src_install() {
	default
	env -uRESTRICT prepstrip "${ED}"/usr/bin "${ED}"/usr/$(get_libdir)
}
