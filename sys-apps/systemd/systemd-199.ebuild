# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/systemd/systemd-199.ebuild,v 1.2 2013/03/28 22:57:21 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit autotools-utils linux-info multilib pam python-single-r1 systemd udev user

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/systemd"
SRC_URI="http://www.freedesktop.org/software/systemd/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"
IUSE="acl audit cryptsetup doc gcrypt gudev http
	introspection +kmod lzma pam python qrcode selinux static-libs
	tcpd vanilla xattr"

MINKV="2.6.39"

COMMON_DEPEND=">=sys-apps/dbus-1.6.8-r1
	>=sys-apps/util-linux-2.20
	sys-libs/libcap
	acl? ( sys-apps/acl )
	audit? ( >=sys-process/audit-2 )
	cryptsetup? ( >=sys-fs/cryptsetup-1.4.2 )
	gcrypt? ( >=dev-libs/libgcrypt-1.4.5 )
	gudev? ( >=dev-libs/glib-2 )
	http? ( net-libs/libmicrohttpd )
	introspection? ( >=dev-libs/gobject-introspection-1.31.1 )
	kmod? ( >=sys-apps/kmod-12 )
	lzma? ( app-arch/xz-utils )
	pam? ( virtual/pam )
	python? ( ${PYTHON_DEPS} )
	qrcode? ( media-gfx/qrencode )
	selinux? ( sys-libs/libselinux )
	tcpd? ( sys-apps/tcp-wrappers )
	xattr? ( sys-apps/attr )"

# baselayout-2.2 has /run
RDEPEND="${COMMON_DEPEND}
	>=sys-apps/baselayout-2.2
	>=sys-apps/hwids-20130309-r1[udev]
	|| (
		>=sys-apps/util-linux-2.22
		<sys-apps/sysvinit-2.88-r4
	)
	!sys-auth/nss-myhostname
	!<sys-libs/glibc-2.10
	!sys-fs/udev"

# sys-fs/quota is necessary to store correct paths in unit files
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gperf
	>=dev-util/intltool-0.50
	sys-fs/quota
	>=sys-kernel/linux-headers-${MINKV}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.18 )"

src_prepare() {
	local PATCHES=(
		"${FILESDIR}/199-firmware.patch"
	)
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--localstatedir=/var
		--with-firmware-path="/lib/firmware/updates:/lib/firmware"
		# install everything to /usr
		--with-rootprefix=/usr
		--with-rootlibdir=/usr/$(get_libdir)
		# but pam modules have to lie in /lib*
		--with-pamlibdir=/$(get_libdir)/security
		# make sure we get /bin:/sbin in $PATH
		--enable-split-usr
		# disable sysv compatibility
		--with-sysvinit-path=
		--with-sysvrcnd-path=
		# just text files
		--enable-polkit
		# no deps
		--enable-keymap
		--enable-efi
		# optional components/dependencies
		$(use_enable acl)
		$(use_enable audit)
		$(use_enable cryptsetup libcryptsetup)
		$(use_enable doc gtk-doc)
		$(use_enable gcrypt)
		$(use_enable gudev)
		$(use_enable http microhttpd)
		$(use_enable introspection)
		$(use_enable kmod)
		$(use_enable lzma xz)
		$(use_enable pam)
		$(use_with python)
		$(use python && echo PYTHON_CONFIG=/usr/bin/python-config-${EPYTHON#python})
		$(use_enable qrcode qrencode)
		$(use_enable selinux)
		$(use_enable tcpd tcpwrap)
		$(use_enable xattr)
	)

	# Keep using the one where the rules were installed.
	MY_UDEVDIR=$(get_udevdir)

	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile \
		udevlibexecdir="${MY_UDEVDIR}"
}

src_install() {
	autotools-utils_src_install -j1 \
		udevlibexecdir="${MY_UDEVDIR}" \
		dist_udevhwdb_DATA=

	# zsh completion
	insinto /usr/share/zsh/site-functions
	newins shell-completion/systemd-zsh-completion.zsh "_${PN}"

	# remove pam.d plugin .la-file
	prune_libtool_files --modules

	# compat for init= use
	dosym ../usr/lib/systemd/systemd /bin/systemd
	dosym ../lib/systemd/systemd /usr/bin/systemd
	# rsyslog.service depends on it...
	dosym ../usr/bin/systemctl /bin/systemctl

	# we just keep sysvinit tools, so no need for the mans
	rm "${D}"/usr/share/man/man8/{halt,poweroff,reboot,runlevel,shutdown,telinit}.8 \
		|| die
	rm "${D}"/usr/share/man/man1/init.1 || die

	if ! use vanilla; then
		# Create /run/lock as required by new baselay/OpenRC compat.
		systemd_dotmpfilesd "${FILESDIR}"/gentoo-run.conf

		# Add mount-rules for /var/lock and /var/run, bug #433607
		systemd_dounit "${FILESDIR}"/var-{lock,run}.mount
		systemd_enable_service sysinit.target var-lock.mount
		systemd_enable_service sysinit.target var-run.mount
	fi

	# Disable storing coredumps in journald, bug #433457
	mv "${D}"/usr/lib/sysctl.d/50-coredump.conf{,.disabled} || die

	# Preserve empty dirs in /etc & /var, bug #437008
	keepdir /etc/binfmt.d /etc/modules-load.d /etc/tmpfiles.d \
		/etc/systemd/ntp-units.d /etc/systemd/user /var/lib/systemd

	# Check whether we won't break user's system.
	[[ -x "${D}"/bin/systemd ]] || die '/bin/systemd symlink broken, aborting.'
	[[ -x "${D}"/usr/bin/systemd ]] || die '/usr/bin/systemd symlink broken, aborting.'
}

pkg_preinst() {
	local CONFIG_CHECK="~AUTOFS4_FS ~BLK_DEV_BSG ~CGROUPS ~DEVTMPFS
		~FANOTIFY ~HOTPLUG ~INOTIFY_USER ~IPV6 ~NET ~PROC_FS ~SIGNALFD
		~SYSFS ~!IDE ~!SYSFS_DEPRECATED ~!SYSFS_DEPRECATED_V2"
	kernel_is -ge ${MINKV//./ } || ewarn "Kernel version at least ${MINKV} required"
	check_extra_config
}

optfeature() {
	local i desc=${1} text
	shift

	text="  [\e[1m$(has_version ${1} && echo I || echo ' ')\e[0m] ${1}"
	shift

	for i; do
		elog "${text}"
		text="& [\e[1m$(has_version ${1} && echo I || echo ' ')\e[0m] ${1}"
	done
	elog "${text} (${desc})"
}

pkg_postinst() {
	# for udev rules
	enewgroup dialout

	enewgroup systemd-journal
	if use http; then
		enewgroup systemd-journal-gateway
		enewuser systemd-journal-gateway -1 -1 -1 systemd-journal-gateway
	fi
	systemd_update_catalog

	if [[ ! -L "${ROOT}"/etc/mtab ]]; then
		ewarn "Upstream suggests that the /etc/mtab file should be a symlink to /proc/mounts."
		ewarn "It is known to cause users being unable to unmount user mounts. If you don't"
		ewarn "require that specific feature, please call:"
		ewarn "	$ ln -sf '${ROOT}proc/self/mounts' '${ROOT}etc/mtab'"
		ewarn
	fi

	elog "To get additional features, a number of optional runtime dependencies may"
	elog "be installed:"
	optfeature 'for GTK+ systemadm UI and gnome-ask-password-agent' \
		'sys-apps/systemd-ui'

	# read null-terminated argv[0] from PID 1
	# and see which path to systemd was used (if any)
	local init_path
	IFS= read -r -d '' init_path < /proc/1/cmdline
	if [[ ${init_path} == */bin/systemd ]]; then
		ewarn
		ewarn "You are using a compatibility symlink to run systemd. The symlink"
		ewarn "will be removed in near future. Please update your bootloader"
		ewarn "to use:"
		ewarn
		ewarn "	init=/usr/lib/systemd/systemd"
	fi
}

pkg_prerm() {
	# If removing systemd completely, remove the catalog database.
	if [[ ! ${REPLACED_BY_VERSION} ]]; then
		rm -f -v "${EROOT}"/var/lib/systemd/catalog/database
	fi
}
