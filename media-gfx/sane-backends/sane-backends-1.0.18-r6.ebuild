# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-backends/sane-backends-1.0.18-r6.ebuild,v 1.20 2012/06/08 03:01:10 zmedico Exp $

EAPI="1"

inherit eutils flag-o-matic multilib user

IUSE="usb gphoto2 ipv6 v4l doc"

DESCRIPTION="Scanner Access Now Easy - Backends"
HOMEPAGE="http://www.sane-project.org/"

RDEPEND="virtual/jpeg
	amd64? ( sys-libs/libieee1284 )
	x86? ( sys-libs/libieee1284 )
	usb? ( virtual/libusb:0 )
	gphoto2? ( media-libs/libgphoto2 )
	v4l? ( sys-kernel/linux-headers )"

DEPEND="${RDEPEND}
	doc? (
		virtual/latex-base
		dev-texlive/texlive-latexextra
	)
	>=sys-apps/sed-4"

# We now use new syntax construct (SUBSYSTEMS!="usb|usb_device)
RDEPEND="${RDEPEND}
	!<sys-fs/udev-114"

BROTHERMFCPATCHVER="1.0.18"
BROTHERMFCDRIVER="sane-${BROTHERMFCPATCHVER}-brother-driver.diff"

# Could not access via ftp on 2006-07-20
SRC_URI="http://alioth.debian.org/download.php/1669/sane-backends-1.0.18.tar.gz
	ftp://ftp.sane-project.org/pub/sane/${P}/${P}.tar.gz
	ftp://ftp.sane-project.org/pub/sane/old-versions/${P}/${P}.tar.gz
	usb? ( mirror://gentoo/${BROTHERMFCDRIVER}.bz2
		http://dev.gentoo.org/~phosphan/${BROTHERMFCDRIVER}.bz2 )"
SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"

# To enable specific backends, define SANE_BACKENDS with the backends you want
# in those:
#
# abaton agfafocus apple artec as6e avision bh brother canon
# canon630u coolscan coolscan2 dc25 dmc
# epson fujitsu genesys gt68xx hp leo lexmark matsushita microtek
# microtek2 mustek mustek_usb nec pie pixma plustek
# plustek_pp ricoh s9036 sceptre sharp
# sp15c st400 tamarack test teco1 teco2 teco3 umax umax_pp umax1220u
# artec_eplus48u ma1509 ibm hp5400 u12 snapscan niash sm3840 hp4200
# sm3600 hp3500 stv680"

# Note that some backends has specific dependencies which make the compilation
# fail because not supported on your current platform.

pkg_setup() {
	enewgroup scanner

	IEEE1284_BACKENDS="canon_pp hpsj5s mustek_pp"

	if [[ "${SANE_BACKENDS}" != "" ]]; then
		use gphoto2 && SANE_BACKENDS="${SANE_BACKENDS} gphoto2"
		use v4l && SANE_BACKENDS="${SANE_BACKENDS} v4l"
		use usb && SANE_BACKENDS="${SANE_BACKENDS} sm3600"
	fi

	if ! use x86 && ! use amd64; then
		tmp="${SANE_BACKENDS}"
		for backend in ${IEEE1284_BACKENDS}; do
			if [[ "${tmp/$backend/}" != "${SANE_BACKENDS}" ]]; then
				ewarn "You selected a backend which is disabled because it's not usable in your arch."
			fi
		done
	fi
}

src_unpack() {
	if [ -z "${SANE_BACKENDS}" ]; then
		elog "You can use the variable SANE_BACKENDS to pick backends"
		elog "instead of building all of them."
	fi
	unpack ${A}
	if use usb; then
		unpack ${BROTHERMFCDRIVER}.bz2
	fi

	cd "${S}"

	if ! use doc; then
		sed -i -e 's:@USE_LATEX@:no:' doc/Makefile.in
	fi

	if use usb; then
		epatch "${WORKDIR}/${BROTHERMFCDRIVER}"
		sed -e 's/bh canon/bh brother canon/' -i configure || \
			die "could not add 'brother' to backend list"
	fi
	epatch "${FILESDIR}"/udev-rule-4.patch
	epatch "${FILESDIR}"/broken_coolscan.patch
}

src_compile() {
	append-flags -fno-strict-aliasing
	SANEI_JPEG="sanei_jpeg.o" SANEI_JPEG_LO="sanei_jpeg.lo" \
	BACKENDS="${SANE_BACKENDS}" \
	econf \
		$(use_enable usb libusb) \
		$(use_with gphoto2) \
		$(use_enable ipv6) \
		${myconf} || die "econf failed"

	emake VARTEXFONTS="${T}/fonts" || die

	if use usb; then
		cd tools/hotplug
		grep -v '^$' libsane.usermap > libsane.usermap.new
		mv libsane.usermap.new libsane.usermap
	fi
}

src_install () {
	make INSTALL_LOCKPATH="" DESTDIR="${D}" install \
		docdir=/usr/share/doc/${PF}
	keepdir /var/lib/lock/sane
	fowners root:scanner /var/lib/lock/sane
	fperms g+w /var/lib/lock/sane
	dodir /etc/env.d
	if use usb; then
		cd tools/hotplug
		insinto /etc/hotplug/usb
		exeinto /etc/hotplug/usb
		doins libsane.usermap
		doexe libusbscanner
		newdoc README README.hotplug
		echo >> "${D}"/etc/env.d/30sane "USB_DEVFS_PATH=/dev/bus/usb"
		cd ../..
	fi
	cd tools/udev
	dodir /lib/udev/rules.d
	insinto /lib/udev/rules.d
	newins libsane.rules 70-libsane.rules
	cd ../..
	dodoc NEWS AUTHORS ChangeLog* README README.linux
	echo "SANE_CONFIG_DIR=/etc/sane.d" >> "${D}"/etc/env.d/30sane
	find "${D}" -name "*.la" | while read file; do rm "${file}"; done
}
