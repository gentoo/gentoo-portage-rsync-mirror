# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/systemd/systemd-198-r2.ebuild,v 1.1 2013/03/23 07:46:53 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit autotools-utils linux-info multilib pam python-single-r1 systemd user

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/systemd"
SRC_URI="http://www.freedesktop.org/software/systemd/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"
IUSE="acl audit cryptsetup efi gcrypt http +kmod lzma pam python
	qrcode selinux tcpd vanilla xattr"

MINKV="2.6.39"

COMMON_DEPEND=">=sys-apps/dbus-1.6.8-r1
	>=sys-apps/util-linux-2.20
	~sys-fs/udev-${PV}[acl?]
	!<sys-fs/udev-198-r4
	sys-libs/libcap
	acl? ( sys-apps/acl )
	audit? ( >=sys-process/audit-2 )
	cryptsetup? ( >=sys-fs/cryptsetup-1.4.2 )
	gcrypt? ( >=dev-libs/libgcrypt-1.4.5 )
	http? ( net-libs/libmicrohttpd )
	kmod? ( >=sys-apps/kmod-12 )
	lzma? ( app-arch/xz-utils )
	pam? ( virtual/pam )
	python? ( ${PYTHON_DEPS} )
	qrcode? ( media-gfx/qrencode )
	selinux? ( sys-libs/libselinux )
	tcpd? ( sys-apps/tcp-wrappers )
	xattr? ( sys-apps/attr )"

RDEPEND="${COMMON_DEPEND}
	sys-apps/hwids
	|| (
		>=sys-apps/util-linux-2.22
		<sys-apps/sysvinit-2.88-r4
	)
	!sys-auth/nss-myhostname
	!<sys-libs/glibc-2.10
	!<sys-fs/udev-197-r3"

# sys-fs/quota is necessary to store correct paths in unit files
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/gperf
	dev-util/intltool
	sys-fs/quota
	>=sys-kernel/linux-headers-${MINKV}"

# eautomake will likely trigger a full autoreconf
DEPEND+=" dev-libs/gobject-introspection
	>=dev-libs/libgcrypt-1.4.5
	>=dev-util/gtk-doc-1.18"

src_prepare() {
	# link against external udev.
	sed -i -e 's:lib\(udev\)\.la:-l\1:' Makefile.am

	local PATCHES=(
		"${FILESDIR}"/198-0001-Disable-udev-targets.patch
		"${FILESDIR}"/198-0002-build-sys-break-dependency-loop-between-libsystemd-i.patch
		"${FILESDIR}"/198-0003-build-sys-link-libsystemd-login-also-against-libsyst.patch
	)

	autotools-utils_src_prepare

	# XXX: support it within eclass
	eautomake
}

src_configure() {
	local myeconfargs=(
		--localstatedir=/var
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
		# udev parts
		--disable-introspection
		--disable-gtk-doc
		--disable-gudev
		# just text files
		--enable-polkit
		# optional components/dependencies
		$(use_enable acl)
		$(use_enable audit)
		$(use_enable cryptsetup libcryptsetup)
		$(use_enable efi)
		$(use_enable gcrypt)
		$(use_enable http microhttpd)
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

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install \
		udevlibexecdir=/lib/udev

	# Moved to udev
	rm "${D}$(systemd_get_unitdir)/initrd-udevadm-cleanup-db.service" || die

	# zsh completion
	insinto /usr/share/zsh/site-functions
	newins shell-completion/systemd-zsh-completion.zsh "_${PN}"

	# remove pam.d plugin .la-file
	prune_libtool_files --modules

	# move nss_myhostname to rootfs (bug #460640)
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/libnss_myhostname* "${D}"/$(get_libdir)/ \
		|| die "Unable to move nss_myhostname to rootfs"

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
	mv "${D}"/usr/lib/sysctl.d/coredump.conf \
		"${D}"/etc/sysctl.d/coredump.conf.disabled || die

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
	enewgroup systemd-journal
	if use http; then
		enewgroup systemd-journal-gateway
		enewuser systemd-journal-gateway -1 -1 -1 systemd-journal-gateway
	fi
	systemd_update_catalog

	mkdir -p "${ROOT}"/run || ewarn "Unable to mkdir /run, this could mean trouble."
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
	elog

	ewarn "Please note this is a work-in-progress and many packages in Gentoo"
	ewarn "do not supply systemd unit files yet. You are testing it on your own"
	ewarn "responsibility. Please remember than you can pass:"
	ewarn "	init=/sbin/init"
	ewarn "to your kernel to boot using sysvinit / OpenRC."
}

pkg_prerm() {
	# If removing systemd completely, remove the catalog database.
	if [[ ! ${REPLACED_BY_VERSION} ]]; then
		rm -f -v "${EROOT}"/var/lib/systemd/catalog/database
	fi
}
