# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.02.99-r1.ebuild,v 1.1 2013/08/04 21:05:20 ssuominen Exp $

EAPI=5
inherit eutils multilib toolchain-funcs autotools linux-info udev systemd

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${PN/lvm/LVM}.${PV}.tgz
		 ftp://sources.redhat.com/pub/lvm2/old/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"

IUSE="readline static static-libs clvm cman +lvm1 lvm2create_initrd selinux +udev +thin"

DEPEND_COMMON="clvm? ( cman? ( =sys-cluster/cman-3* ) =sys-cluster/libdlm-3* )
	readline? ( sys-libs/readline )
	udev? ( >=virtual/udev-200[static-libs?] )"
# /run is now required for locking during early boot. /var cannot be assumed to
# be available.
RDEPEND="${DEPEND_COMMON}
	!<sys-apps/openrc-0.10.1
	>=sys-apps/baselayout-2.1-r1
	!!sys-fs/lvm-user
	!!sys-fs/clvm
	>=sys-apps/util-linux-2.16
	lvm2create_initrd? ( sys-apps/makedev )
	thin? ( sys-block/thin-provisioning-tools )"
# Upgrading to this LVM will break older cryptsetup
RDEPEND="${RDEPEND}
	!<sys-fs/cryptsetup-1.1.2"
DEPEND="${DEPEND_COMMON}
	virtual/pkgconfig
	>=sys-devel/binutils-2.20.1-r1
	static? ( udev? ( >=virtual/udev-200[static-libs] ) )"

S=${WORKDIR}/${PN/lvm/LVM}.${PV}

#QA_MULTILIB_PATHS="usr/lib/systemd/system-generators/.*" #479520

pkg_setup() {
	local CONFIG_CHECK="~SYSVIPC"
	use udev && local WARNING_SYSVIPC="CONFIG_SYSVIPC:\tis not set (required for udev sync)\n"
	check_extra_config
	# 1. Genkernel no longer copies /sbin/lvm blindly.
	if use static; then
		elog "Warning, we no longer overwrite /sbin/lvm and /sbin/dmsetup with"
		elog "their static versions. If you need the static binaries,"
		elog "you must append .static to the filename!"
	fi
}

src_prepare() {
	# Gentoo specific modification(s)
	epatch "${FILESDIR}"/${PN}-2.02.99-example.conf.in.patch

	# Not merged upstream, should be reviewed and forwarded:
	epatch \
		"${FILESDIR}"/${PN}-2.02.63-always-make-static-libdm.patch \
		"${FILESDIR}"/${PN}-2.02.56-lvm2create_initrd.patch \
		"${FILESDIR}"/${PN}-2.02.88-respect-cc.patch
	epatch "${FILESDIR}"/${PN}-2.02.67-createinitrd.patch #301331
	epatch "${FILESDIR}"/${PN}-2.02.99-locale-muck.patch #330373
	epatch "${FILESDIR}"/${PN}-2.02.70-asneeded.patch # -Wl,--as-needed
	epatch "${FILESDIR}"/${PN}-2.02.92-dynamic-static-ldflags.patch #332905
	epatch "${FILESDIR}"/${PN}-2.02.97-udev-static.patch #370217

	sed -i -e 's:/usr/sbin/lvm:/sbin/lvm:' scripts/lvm2_activation_generator_systemd_red_hat.c || die #479626

	# Fix calling AR directly with USE static, bug #444082, convert to patch and forward to upstream
	if use static ; then
		sed -i -e "s:\$(AR) rs \$@ \$(OBJECTS) lvmcmdlib.o lvm2cmd-static.o:$(tc-getAR) rs \$@ \$(OBJECTS) lvmcmdlib.o lvm2cmd-static.o:" \
			tools/Makefile.in || die
	fi

	eautoreconf
}

src_configure() {
	local myconf
	local buildmode

	myconf="${myconf} --enable-dmeventd"
	myconf="${myconf} --enable-cmdlib"
	myconf="${myconf} --enable-applib"
	myconf="${myconf} --enable-fsadm"
	myconf="${myconf} --enable-lvmetad"

	# Most of this package does weird stuff.
	# The build options are tristate, and --without is NOT supported
	# options: 'none', 'internal', 'shared'
	if use static ; then
		einfo "Building static LVM, for usage inside genkernel"
		buildmode="internal"
		# This only causes the .static versions to become available
		# We explicitly provide the .static versions so that they can be included in
		# initramfs environments.
		myconf="${myconf} --enable-static_link"
	else
		ewarn "Building shared LVM, it will not work inside genkernel!"
		buildmode="shared"
	fi

	# dmeventd requires mirrors to be internal, and snapshot available
	# so we cannot disable them
	myconf="${myconf} --with-mirrors=internal"
	myconf="${myconf} --with-snapshots=internal"
	use thin \
		&& myconf="${myconf} --with-thin=internal" \
		|| myconf="${myconf} --with-thin=none"

	if use lvm1 ; then
		myconf="${myconf} --with-lvm1=${buildmode}"
	else
		myconf="${myconf} --with-lvm1=none"
	fi

	# disable O_DIRECT support on hppa, breaks pv detection (#99532)
	use hppa && myconf="${myconf} --disable-o_direct"

	if use clvm; then
		myconf="${myconf} --with-cluster=${buildmode}"
		# 4-state! Make sure we get it right, per bug 210879
		# Valid options are: none, cman, gulm, all
		#
		# 2009/02:
		# gulm is removed now, now dual-state:
		# cman, none
		# all still exists, but is not needed
		#
		# 2009/07:
		# TODO: add corosync and re-enable ALL
		local clvmd=""
		use cman && clvmd="cman"
		#clvmd="${clvmd/cmangulm/all}"
		[ -z "${clvmd}" ] && clvmd="none"
		myconf="${myconf} --with-clvmd=${clvmd}"
		myconf="${myconf} --with-pool=${buildmode}"
	else
		myconf="${myconf} --with-clvmd=none --with-cluster=none"
	fi

	local udevdir="${EPREFIX}/lib/udev/rules.d"
	use udev && udevdir="${EPREFIX}/$(get_udevdir)/rules.d"

	econf \
		$(use_enable readline) \
		$(use_enable selinux) \
		--enable-pkgconfig \
		--with-confdir="${EPREFIX}/etc" \
		--sbindir="${EPREFIX}/sbin" \
		--with-staticdir="${EPREFIX}/sbin" \
		--libdir="${EPREFIX}/$(get_libdir)" \
		--with-usrlibdir="${EPREFIX}/usr/$(get_libdir)" \
		--with-default-dm-run-dir=/run \
		--with-default-run-dir=/run/lvm \
		--with-default-locking-dir=/run/lock/lvm \
		--with-dmeventd-path=/sbin/dmeventd \
		--with-default-pid-dir=/run \
		$(use_enable udev udev_rules) \
		$(use_enable udev udev_sync) \
		$(use_with udev udevdir "${udevdir}") \
		"$(systemd_with_unitdir)" \
		${myconf} \
		CLDFLAGS="${LDFLAGS}"
}

src_compile() {
	pushd include >/dev/null
	emake
	popd >/dev/null

	emake AR="$(tc-getAR)"
	emake CC="$(tc-getCC)" -C scripts lvm2_activation_generator_systemd_red_hat
}

src_install() {
	local inst
	for inst in install install_systemd_units install_systemd_generators install_tmpfiles_configuration; do
		emake DESTDIR="${D}" ${inst}
	done

	dodoc README VERSION* WHATS_NEW WHATS_NEW_DM doc/*.{c,txt} conf/*.conf
	newinitd "${FILESDIR}"/lvm.rc-2.02.95-r2 lvm
	newinitd "${FILESDIR}"/lvm-monitoring.initd-2.02.67-r2 lvm-monitoring
	newconfd "${FILESDIR}"/lvm.confd-2.02.28-r2 lvm
	if use clvm; then
		newinitd "${FILESDIR}"/clvmd.rc-2.02.39 clvmd
		newconfd "${FILESDIR}"/clvmd.confd-2.02.39 clvmd
	fi

	# move shared libs to /lib(64)
	if use static-libs; then
		dolib.a libdm/ioctl/libdevmapper.a
		dolib.a libdaemon/client/libdaemonclient.a #462908
		#gen_usr_ldscript libdevmapper.so
	fi

	if use lvm2create_initrd; then
		dosbin "${S}"/scripts/lvm2create_initrd/lvm2create_initrd
		doman  "${S}"/scripts/lvm2create_initrd/lvm2create_initrd.8
		newdoc "${S}"/scripts/lvm2create_initrd/README README.lvm2create_initrd
	fi

	insinto /etc
	doins "${FILESDIR}"/dmtab

	# Device mapper stuff
	newinitd "${FILESDIR}"/device-mapper.rc-2.02.95-r2 device-mapper
	newconfd "${FILESDIR}"/device-mapper.conf-1.02.22-r3 device-mapper

	newinitd "${FILESDIR}"/dmeventd.initd-2.02.67-r1 dmeventd
	if use static-libs; then
		dolib.a daemons/dmeventd/libdevmapper-event.a
		#gen_usr_ldscript libdevmapper-event.so
	fi

	use static-libs || \
	rm -f "${D}"/usr/$(get_libdir)/{libdevmapper-event,liblvm2cmd,liblvm2app,libdevmapper}.a

	#insinto /etc/udev/rules.d/
	#newins "${FILESDIR}"/64-device-mapper.rules-2.02.56-r3 64-device-mapper.rules

	# do not rely on /lib -> /libXX link
	sed -i \
		-e "s|/lib/rcscripts/|/$(get_libdir)/rcscripts/|" \
		"${ED}"/etc/init.d/* || die
}

pkg_postinst() {
	ewarn "Make sure the \"lvm\" init script is in the runlevels:"
	ewarn "# rc-update add lvm boot"
	ewarn
	ewarn "Make sure to enable lvmetad in /etc/lvm/lvm.conf if you want"
	ewarn "to enable lvm autoactivation and metadata caching."
}

src_test() {
	einfo "Tests are disabled because of device-node mucking, if you want to"
	einfo "run tests, compile the package and see ${S}/tests"
}
