# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wicd/wicd-1.7.2.4-r3.ebuild,v 1.11 2014/08/02 18:18:19 ago Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="ncurses?,xml"

inherit eutils distutils-r1 linux-info readme.gentoo systemd

DESCRIPTION="A lightweight wired and wireless network manager for Linux"
HOMEPAGE="https://launchpad.net/wicd"
SRC_URI="http://launchpad.net/wicd/1.7/${PV}/+download/${P}.tar.gz
	mac4lin? ( http://dev.gentoo.org/~anarchy/dist/wicd-mac4lin-icons.tar.xz )
	ambiance? ( http://freetimesblog.altervista.org/blog/wp-content/uploads/downloads/2010/05/Icone-Wicd-Lucid.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~mips ppc ppc64 x86"
IUSE="doc X ambiance +gtk ioctl libnotify mac4lin ncurses nls +pm-utils"

DEPEND="nls? ( dev-python/Babel )"
RDEPEND="${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	X? (
		gtk? ( dev-python/pygtk )
		|| (
			x11-misc/ktsuss
			x11-libs/gksu
			kde-base/kdesu
			)
	)
	|| (
		net-misc/dhcpcd
		net-misc/dhcp
		net-misc/pump
	)
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	|| (
		sys-apps/net-tools
		sys-apps/ethtool
	)
	!gtk? ( dev-python/pygobject:2[${PYTHON_USEDEP}] )
	ioctl? ( dev-python/python-iwscan dev-python/python-wpactrl )
	libnotify? ( dev-python/notify-python[${PYTHON_USEDEP}] )
	ncurses? (
		dev-python/urwid
		dev-python/pygobject:2[${PYTHON_USEDEP}]
	)
	pm-utils? ( sys-power/pm-utils )
	"

src_prepare() {
	CONFIG_CHECK="~CFG80211_WEXT"
	local WARNING_CFG80211_WEXT="Wireless extensions have not been \
	configured in your kernel.  Wicd will not work unless CFG80211_WEXT is set."
	check_extra_config

	# Fix bug 441966 (urwid-1.1.0 compatibility)
	epatch "${FILESDIR}"/${P}-urwid.patch
	epatch "${FILESDIR}"/${P}-second-urwid.patch
	epatch "${FILESDIR}"/${PN}-1.7.1_beta2-init.patch
	epatch "${FILESDIR}"/${PN}-init-sve-start.patch
	# Add a template for hex psk's and wpa (Bug 306423)
	epatch "${FILESDIR}"/${PN}-1.7.1_pre20111210-wpa-psk-hex-template.patch
	# The Categories entry in the .desktop files is outdated
	epatch "${FILESDIR}"/${P}-fix-desktop-categories.patch
	# Fix bug 416579 (should be included in next release)
	epatch "${FILESDIR}"/${P}-fix-dbus-error.patch
	# get rid of opts variable to fix bug 381885
	sed -i "/opts/d" "in/init=gentoo=wicd.in" || die
	# Make init script provide net per bug 405775
	epatch "${FILESDIR}"/${PN}-1.7.1-provide-net.patch
	# Need to ensure that generated scripts use Python 2 at run time.
	sed -e "s:self.python = '/usr/bin/python':self.python = '/usr/bin/python2':" \
	  -i setup.py || die "sed failed"
	# Fix misc helper scripts:
	sed -e "s:/usr/bin/env python:/usr/bin/env python2:" \
		-i wicd/suspend.py wicd/autoconnect.py wicd/monitor.py
	if use nls; then
	  # Asturian is faulty with PyBabel
	  # (https://bugs.launchpad.net/wicd/+bug/928589)
	  rm po/ast.po
	  # zh_CN fails with newer PyBabel (Aug 2013)
	  rm po/zh_CN.po
	else
	  # nuke translations
	  rm po/*.po
	fi

	DOC_CONTENTS="To start wicd at boot with openRC, add
		/etc/init.d/wicd to a runlevel and: (1) Remove all net.*
		initscripts (except for net.lo) from all runlevels (2) Add these
		scripts to the RC_PLUG_SERVICES line in /etc/rc.conf (For
		example, rc_hotplug=\"!net.eth* !net.wlan*\")"
}

src_configure() {
	local myconf
	use gtk || myconf="${myconf} --no-install-gtk"
	use libnotify || myconf="${myconf} --no-use-notifications"
	use ncurses || myconf="${myconf} --no-install-ncurses"
	use pm-utils || myconf="${myconf} --no-install-pmutils"
	python_export_best
	"${EPYTHON}" ./setup.py configure --no-install-docs \
		--resume=/usr/share/wicd/scripts/ \
		--suspend=/usr/share/wicd/scripts/ \
		--verbose ${myconf}
}

src_install() {
	distutils-r1_src_install
	keepdir /var/lib/wicd/configurations
	keepdir /etc/wicd/scripts/{postconnect,disconnect,preconnect}
	keepdir /var/log/wicd
	use nls || rm -rf "${D}"/usr/share/locale
	systemd_dounit "${S}/other/wicd.service"

	if use mac4lin; then
		rm -rf "${D}"/usr/share/pixmaps/wicd || die "Failed to remove old icons"
		mv "${WORKDIR}"/wicd "${D}"/usr/share/pixmaps/
	fi
	if use ambiance; then
		# Overwrite tray icons with ambiance icon
		rm "${WORKDIR}/Icone Wicd Lucid"/signal*
		cp "${WORKDIR}/Icone Wicd Lucid"/*.png "${D}"/usr/share/pixmaps/wicd/
	fi
	readme.gentoo_src_install
}

pkg_postinst() {
	# Maintainer's note: the consolekit use flag short circuits a dbus rule and
	# allows the connection. Else, you need to be in the group.
	if ! has_version sys-auth/consolekit; then
		ewarn "Wicd-1.6 and newer requires your user to be in the 'users' group. If"
		ewarn "you are not in that group, then modify /etc/dbus-1/system.d/wicd.conf"
	fi

	readme.gentoo_print_elog
}
