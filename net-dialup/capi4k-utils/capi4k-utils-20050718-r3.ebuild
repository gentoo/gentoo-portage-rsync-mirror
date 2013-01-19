# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capi4k-utils/capi4k-utils-20050718-r3.ebuild,v 1.16 2013/01/19 21:45:15 ssuominen Exp $

inherit eutils multilib linux-info

YEAR_PV="${PV:0:4}"
MON_PV="${PV:4:2}"
DAY_PV="${PV:6:2}"
MY_P="${PN}-${YEAR_PV}-${MON_PV}-${DAY_PV}"
PPPVERSIONS="2.4.2 2.4.3 2.4.4"  # versions in portage

DESCRIPTION="CAPI4Linux Utils"
HOMEPAGE="ftp://ftp.in-berlin.de/pub/capi4linux/"
SRC_URI="ftp://ftp.in-berlin.de/pub/capi4linux/${MY_P}.tar.gz
	ftp://ftp.in-berlin.de/pub/capi4linux/OLD/${MY_P}.tar.gz
	http://voip-cell.eu/gentoo/distfiles/${PF/utils/patches}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="fax pppd tcpd usb pcmcia"

DEPEND="virtual/linux-sources
	virtual/os-headers
	>=sys-apps/sed-4"

RDEPEND="usb? ( sys-apps/hotplug )
	pcmcia? ( sys-apps/pcmciautils )
	dev-lang/perl"

S="${WORKDIR}/${PN}"
PATCHDIR="${WORKDIR}/capi4k-patches"

pkg_setup() {
	# check kernel config
	CONFIG_CHECK="~ISDN ~ISDN_CAPI ~ISDN_CAPI_CAPI20"
	use pppd && CONFIG_CHECK="${CONFIG_CHECK} ~ISDN_CAPI_MIDDLEWARE ~ISDN_CAPI_CAPIFS_BOOL"
	linux-info_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# add ppp-2.4.4 support
	epatch "${PATCHDIR}/pppd244.diff"

	# apply msg2str-safety patch (see bug #170870)
	epatch "${PATCHDIR}/msg2str-safety.diff"

	# apply sys/types patch (needed for glibc-2.7)
	epatch "${FILESDIR}/capi20-types.diff"

	# set our config
	cp -f "${FILESDIR}/config" .config
	# copy init-script config
	cp -f "${FILESDIR}/capi.confd" capi.confd
	# patch all Makefile.* and Rules.make to use our CFLAGS
	sed -i -e "s:^\(CFLAGS.*\)-O2:\1${CFLAGS}:g" */Makefile.* */Rules.make || die "sed failed"
	# patch capi20/Makefile.* to use -fPIC for shared library
	sed -i -e "s:^\(CFLAGS.*\):\1 -fPIC:g" capi20/Makefile.* || die "sed failed"
	# patch pppdcapiplugin/Makefile to use only the ppp versions we want
	sed -i -e "s:^\(PPPVERSIONS = \).*$:\1${PPPVERSIONS}:g" pppdcapiplugin/Makefile || die "sed failed"
	# patch capiinit/capiinit.c to look also in /lib/firmware
	sed -i -e "s:\(\"/lib/firmware/isdn\",\):\1 \"/lib/firmware\",:g" capiinit/capiinit.c || die "sed failed"
	# no, we don't need any devices nodes
	sed -i -e "s:\(sh scripts/makedev.sh\):echo \1:g" Makefile || die "sed failed"
	# add --libdir to configure call in Makefile
	sed -i -e "s:\(\./configure \):\1--libdir=/usr/$(get_libdir) :g" Makefile || die "sed failed"
	# patch /usr/lib/pppd in pppdcapiplugin tree
	sed -i -e "s:/usr/lib/pppd:/usr/$(get_libdir)/pppd:g" \
		pppdcapiplugin/ppp-*/Makefile pppdcapiplugin/{README,*.8} || die "sed failed"

	# USB hotplug
	use usb || sed -i -e "s:^\(CAPI_HOTPLUG_.*\)$:### \1:g" capi.confd
	# build rcapid
	use tcpd || sed -i -e "s:^\(CONFIG_RCAPID=.*\)$:# \1:g" .config
	# build capifax
	use fax || sed -i -e "s:^\(CONFIG_CAPIFAX=.*\)$:# \1:g" .config
	# build pppdcapiplugin
	use pppd || sed -i -e "s:^\(CONFIG_PPPDCAPIPLUGIN=.*\)$:# \1:g" .config
}

src_compile() {
	emake subconfig || die "make subconfig failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# fixing permissions (see bug #136120)
	fperms 0644 /usr/share/man/man8/capiplugin.8

	# install base
	dobin scripts/isdncause
	newinitd "${FILESDIR}/capi.initd" capi
	newconfd capi.confd capi
	insinto /etc
	doins "${FILESDIR}/capi.conf"
	dodoc "${FILESDIR}/README.gentoo" scripts/makedev.sh

	# install USB hotplug stuff
	if use usb; then
		insinto /etc/hotplug/blacklist.d
		newins "${FILESDIR}/capi.blacklist" capi
		insinto /etc/hotplug/usb
		newins "${FILESDIR}/capi.usermap" capi.usermap
		exeinto /etc/hotplug/usb
		newexe "${FILESDIR}/capi.hotplug" capi
	fi

	# install PCMCIA stuff
	if use pcmcia; then
		insinto /etc/pcmcia
		newins "${FILESDIR}/capi.pcmcia.conf" capi.conf
		exeinto /etc/pcmcia
		newexe "${FILESDIR}/capi.pcmcia" capi
	fi

	# install rcapid stuff
	if use tcpd; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/rcapid.xinetd" rcapid
		newdoc rcapid/README README.rcapid
	fi

	# install pppdcapiplugin stuff
	if use pppd; then
		insinto /etc/ppp/peers
		doins pppdcapiplugin/peers/t-dsl
		docinto pppdcapiplugin
		dodoc pppdcapiplugin/README pppdcapiplugin/examples/*
	fi
}

pkg_postinst() {
	elog
	elog "Please read the instructions in README.gentoo in:"
	elog "/usr/share/doc/${PF}/"
	elog
	elog "Annotation for active AVM ISDN boards (B1 ISA/PCI, ...):"
	elog "If you run"
	elog "  emerge isdn-firmware"
	elog "you will probably find your board's firmware in /lib/firmware."
	elog
	elog "If you have another active ISDN board, you should create"
	elog "/lib/firmware and copy there your board's firmware."
	elog
	elog "There're several other packages available, which might have"
	elog "the CAPI driver you need for your card(s):"
	elog "  net-dialup/fritzcapi - AVM passive ISDN controllers"
	elog "  net-dialup/fcdsl     - AVM ISDN/DSL controllers PCI/USB"
	elog
	ewarn "If you're upgrading from an older capi4k-utils, you must recompile"
	ewarn "the other packages on your system that link with libcapi after the"
	ewarn "upgrade completes. To perform this action, please run revdep-rebuild"
	ewarn "in package app-portage/gentoolkit."
	ewarn
}
