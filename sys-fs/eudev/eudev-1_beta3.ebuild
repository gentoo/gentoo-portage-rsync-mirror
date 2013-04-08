# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/eudev/eudev-1_beta3.ebuild,v 1.3 2013/04/08 01:35:57 blueness Exp $

EAPI=5

KV_min=2.6.31

inherit autotools eutils linux-info

if [[ ${PV} = 9999* ]]
then
	EGIT_REPO_URI="git://github.com/gentoo/eudev.git"
	inherit git-2
else
	SRC_URI="http://dev.gentoo.org/~axs/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~x86"
fi

DESCRIPTION="Linux dynamic and persistent device naming support (aka userspace devfs)"
HOMEPAGE="https://github.com/gentoo/eudev"

LICENSE="LGPL-2.1 MIT GPL-2"
SLOT="0"
IUSE="doc gudev hwdb kmod introspection legacy-libudev keymap +modutils +openrc rule-generator selinux static-libs"

RESTRICT="test"

COMMON_DEPEND="gudev? ( dev-libs/glib:2 )
	kmod? ( sys-apps/kmod )
	introspection? ( >=dev-libs/gobject-introspection-1.31.1 )
	selinux? ( sys-libs/libselinux )
	>=sys-apps/util-linux-2.20
	!<sys-libs/glibc-2.11"

DEPEND="${COMMON_DEPEND}
	keymap? ( dev-util/gperf )
	>=dev-util/intltool-0.40.0
	virtual/pkgconfig
	virtual/os-headers
	!<sys-kernel/linux-headers-${KV_min}
	doc? ( dev-util/gtk-doc )
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt"

RDEPEND="${COMMON_DEPEND}
	hwdb? ( >=sys-apps/hwids-20121202.2[udev] )
	!sys-fs/udev
	!sys-apps/coldplug
	!sys-apps/systemd
	!<sys-fs/lvm2-2.02.97
	!sys-fs/device-mapper
	!<sys-fs/udev-init-scripts-18"

PDEPEND=">=virtual/udev-180
	openrc? ( >=sys-fs/udev-init-scripts-18 )"

udev_check_KV()
{
	if kernel_is lt ${KV_min//./ }
	then
		return 1
	fi
	return 0
}

pkg_pretend()
{
	ewarn "Eudev now implements predictable network interface renaming rules, as per"
	ewarn "http://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames"
	ewarn
	ewarn "Unless you are upgrading from eudev-1_beta3, this functionality is DISABLED"
	ewarn "BY DEFAULT using a stub rule file called /etc/udev/rules.d/80-net-name-slot.rules"
	ewarn
	ewarn "If you are migrating from sys-fs/udev-197 and above, and you already use this"
	ewarn "feature, please make sure to remove that stub file before rebooting, otherwise"
	ewarn "your network interface ids will be supplied by the kernel."
	ewarn
	ewarn "To enable support for these new interface names in eudev, please remove the stub:"
	ewarn "\trm /etc/udev/rules.d/80-net-name-slot.rules\t\t(as root)"
	if has_version "<sys-fs/udev-180" && ! use legacy-libudev; then
	ewarn
	ewarn "This version of eudev does not contain the libudev.so.0 library by "
	ewarn "default.  This is an issue when migrating from sys-fs/udev-180 or older."
	ewarn
	ewarn "Removal of libudev.so.0 will effectively break any active Xorg sessions, and"
	ewarn "will probably have repercussions with other software as well.  A revdep-rebuild"
	ewarn "is required to resolve these issues."
	ewarn
	ewarn "Add USE=legacy-libudev to tell eudev to install a copy of libudev.so.0, if"
	ewarn "you wish to continue to use your system while migrating to libudev.so.1"
	else
	if use legacy-libudev ; then
	ewarn
	ewarn "You are installing eudev with USE=legacy-libudev , this should only be used"
	ewarn "to support binary-only applications or legacy applications while in the"
	ewarn "process of doing a full systems upgrade, that require libudev.so.0 -- it is"
	ewarn "HIGHLY RECOMMENDED to leave this flag disabled unless absolutely necessary."
	fi
	fi
	ewarn
}

pkg_setup()
{
	# required kernel options
	CONFIG_CHECK="~BLK_DEV_BSG ~DEVTMPFS ~!IDE ~INOTIFY_USER ~SIGNALFD ~!SYSFS_DEPRECATED ~!SYSFS_DEPRECATED_V2"
	ERROR_DEVTMPFS="DEVTMPFS is not set in this kernel. Udev will not run."

	linux-info_pkg_setup

	if ! udev_check_KV
	then
		eerror "Your kernel version (${KV_FULL}) is too old to run ${P}"
		eerror "It must be at least ${KV_min}!"
	fi

	KV_FULL_SRC=${KV_FULL}
	get_running_version
	if ! udev_check_KV
	then
		eerror
		eerror "Your running kernel version (${KV_FULL}) is too old"
		eerror "for this version of udev."
		eerror "You must upgrade your kernel or downgrade udev."
	fi

	# for USE=legacy-libudev
	QA_SONAME_NO_SYMLINK="$(get_libdir)/libudev.so.0"
}

src_prepare()
{
	# change rules back to group uucp instead of dialout for now
	sed -e 's/GROUP="dialout"/GROUP="uucp"/' \
		-i rules/*.rules \
	|| die "failed to change group dialout to uucp"

	epatch_user

	if [[ ! -e configure ]]
	then
		if use doc
		then
			gtkdocize --docdir docs || die "gtkdocize failed"
		else
			echo 'EXTRA_DIST =' > docs/gtk-doc.make
		fi
		eautoreconf
	else
		elibtoolize
	fi
}

src_configure()
{
	local econf_args

	econf_args=(
		ac_cv_search_cap_init=
		ac_cv_header_sys_capability_h=yes
		DBUS_CFLAGS=' '
		DBUS_LIBS=' '
		--with-rootprefix=
		--docdir=/usr/share/doc/${PF}
		--libdir=/usr/$(get_libdir)
		--with-firmware-path="${EPREFIX}usr/lib/firmware/updates:${EPREFIX}usr/lib/firmware:${EPREFIX}lib/firmware/updates:${EPREFIX}lib/firmware"
		--with-html-dir="/usr/share/doc/${PF}/html"
		--with-rootlibdir=/$(get_libdir)
		--enable-split-usr
		--exec-prefix=/
		$(use_enable doc gtk-doc)
		$(use_enable gudev)
		$(use_enable introspection)
		$(use_enable keymap)
		$(use_enable kmod libkmod)
		$(use_enable modutils modules)
		$(use_enable selinux)
		$(use_enable static-libs static)
		$(use_enable rule-generator)
		$(use_enable legacy-libudev legacylib)
	)
	econf "${econf_args[@]}"
}

src_install()
{
	emake DESTDIR="${D}" install

	prune_libtool_files --all
	rm -rf "${ED}"/usr/share/doc/${PF}/LICENSE.*

	use rule-generator && use openrc && doinitd "${FILESDIR}"/udev-postmount

	# drop distributed hwdb files, they override sys-apps/hwids
	rm -f "${ED}"/etc/udev/hwdb.d/*.hwdb
}

pkg_preinst()
{
	local htmldir
	for htmldir in gudev libudev; do
		if [[ -d ${EROOT}usr/share/gtk-doc/html/${htmldir} ]]
		then
			rm -rf "${EROOT}"usr/share/gtk-doc/html/${htmldir}
		fi
		if [[ -d ${ED}/usr/share/doc/${PF}/html/${htmldir} ]]
		then
			dosym ../../doc/${PF}/html/${htmldir} \
				/usr/share/gtk-doc/html/${htmldir}
		fi
	done
}

pkg_postinst()
{
	mkdir -p "${EROOT}"run

	# "losetup -f" is confused if there is an empty /dev/loop/, Bug #338766
	# So try to remove it here (will only work if empty).
	rmdir "${EROOT}"dev/loop 2>/dev/null
	if [[ -d ${EROOT}dev/loop ]]
	then
		ewarn "Please make sure you remove /dev/loop,"
		ewarn "else losetup may be confused when looking for unused devices."
	fi

	# 64-device-mapper.rules now gets installed by sys-fs/device-mapper
	# remove it if user don't has sys-fs/device-mapper installed, 27 Jun 2007
	if [[ -f ${EROOT}etc/udev/rules.d/64-device-mapper.rules ]] &&
		! has_version sys-fs/device-mapper
	then
		rm -f "${EROOT}"etc/udev/rules.d/64-device-mapper.rules
		einfo "Removed unneeded file 64-device-mapper.rules"
	fi

	use hwdb && udevadm hwdb --update --root="${ROOT%/}"

	# handling of default-disabling of 80-net-name-slot.rules
	if [[ -z $REPLACING_VERSIONS ]] || \
	   [[ ${REPLACING_VERSIONS/-r*/} == "1_beta2" ]] || \
	   [[ ${REPLACING_VERSIONS/-r*/} == "1_beta1" ]]; then
		if [[ ! -e ${EROOT}etc/udev/rules.d/80-net-name-slot.rules ]]; then
		elog
		elog "Writing override rule /etc/udev/rules.d/80-net-name-slot.rules to disable"
		elog "new predictable net iface rename functionality by default"
		echo "# disabling predictible iface rename rules by default, remove this file to enable" \
			>${EROOT}etc/udev/rules.d/80-net-name-slot.rules
		fi
	fi

	ewarn
	ewarn "You need to restart eudev as soon as possible to make the"
	ewarn "upgrade go into effect:"
	ewarn "\t/etc/init.d/udev --nodeps restart"

	if use rule-generator && use openrc; then
		ewarn
		ewarn "Please add the udev-postmount init script to your default runlevel"
		ewarn "to ensure the legacy rule-generator functionality works as reliably"
		ewarn "as possible."
		ewarn "\trc-update add udev-postmount default"
	fi

	elog
	elog "For more information on eudev on Gentoo, writing udev rules, and"
	elog "fixing known issues visit:"
	elog "         http://www.gentoo.org/doc/en/udev-guide.xml"
}
