# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-198-r3.ebuild,v 1.1 2013/03/21 23:02:35 ssuominen Exp $

EAPI=4

# accept4() patch is only in non-live version
if [[ ${PV} = 9999* ]]; then
	KV_min=2.6.39
else
	KV_min=2.6.32
fi

inherit autotools eutils linux-info multilib systemd toolchain-funcs versionator

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/systemd/systemd"
	inherit git-2
else
	patchset=4
	SRC_URI="http://www.freedesktop.org/software/systemd/systemd-${PV}.tar.xz"
	if [[ -n "${patchset}" ]]; then
				SRC_URI="${SRC_URI}
					http://dev.gentoo.org/~ssuominen/${P}-patches-${patchset}.tar.xz
					http://dev.gentoo.org/~williamh/dist/${P}-patches-${patchset}.tar.xz"
			fi
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi

DESCRIPTION="Linux dynamic and persistent device naming support (aka userspace devfs)"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/systemd"

LICENSE="LGPL-2.1 MIT GPL-2"
SLOT="0"
IUSE="acl doc gudev hwdb introspection keymap +kmod +openrc selinux static-libs"

RESTRICT="test"

COMMON_DEPEND=">=sys-apps/util-linux-2.20
	acl? ( sys-apps/acl )
	gudev? ( >=dev-libs/glib-2 )
	introspection? ( >=dev-libs/gobject-introspection-1.31.1 )
	kmod? ( >=sys-apps/kmod-12 )
	selinux? ( >=sys-libs/libselinux-2.1.9 )
	!<sys-libs/glibc-2.11
	!<sys-apps/systemd-${PV}"

DEPEND="${COMMON_DEPEND}
	virtual/os-headers
	virtual/pkgconfig
	!<sys-kernel/linux-headers-${KV_min}
	doc? ( >=dev-util/gtk-doc-1.18 )
	keymap? ( dev-util/gperf )"

if [[ ${PV} = 9999* ]]; then
	DEPEND="${DEPEND}
		app-text/docbook-xsl-stylesheets
		dev-libs/libxslt
		dev-util/gperf
		>=dev-util/intltool-0.50"
fi

RDEPEND="${COMMON_DEPEND}
	openrc? ( !<sys-apps/openrc-0.9.9 )
	!sys-apps/coldplug
	!<sys-fs/lvm2-2.02.97-r1
	!sys-fs/device-mapper
	!<sys-fs/udev-init-scripts-22
	!<sys-kernel/dracut-017-r1
	!<sys-kernel/genkernel-3.4.25
	!<sec-policy/selinux-base-2.20120725-r10"

PDEPEND=">=virtual/udev-197-r1
	hwdb? ( >=sys-apps/hwids-20130309-r1[udev] )
	openrc? ( >=sys-fs/udev-init-scripts-23 )"

S=${WORKDIR}/systemd-${PV}

udev_check_KV() {
	if kernel_is lt ${KV_min//./ }; then
		return 1
	fi
	return 0
}

check_default_rules() {
	# Make sure there are no sudden changes to upstream rules file
	# (more for my own needs than anything else ...)
	local udev_rules_md5=e602584bcabf09cde0f7f9a3c1adda28
	MD5=$(md5sum < "${S}"/rules/50-udev-default.rules)
	MD5=${MD5/  -/}
	if [[ ${MD5} != ${udev_rules_md5} ]]; then
		eerror "50-udev-default.rules has been updated, please validate!"
		eerror "md5sum: ${MD5}"
		die "50-udev-default.rules has been updated, please validate!"
	fi
}

pkg_setup() {
	CONFIG_CHECK="~BLK_DEV_BSG ~DEVTMPFS ~!IDE ~INOTIFY_USER ~!SYSFS_DEPRECATED ~!SYSFS_DEPRECATED_V2 ~SIGNALFD ~EPOLL"

	linux-info_pkg_setup

	if ! udev_check_KV; then
		eerror "Your kernel version (${KV_FULL}) is too old to run ${P}"
		eerror "It must be at least ${KV_min}!"
	fi

	KV_FULL_SRC=${KV_FULL}
	get_running_version
	if ! udev_check_KV; then
		eerror
		eerror "Your running kernel version (${KV_FULL}) is too old"
		eerror "for this version of udev."
		eerror "You must upgrade your kernel or downgrade udev."
	fi
}

src_prepare() {
	if ! [[ ${PV} = 9999* ]]; then
		# secure_getenv() disable for non-glibc systems wrt bug #443030
		if ! [[ $(grep -r secure_getenv * | wc -l) -eq 16 ]]; then
			eerror "The line count for secure_getenv() failed, see bug #443030"
			die
		fi

		# gperf disable if keymaps are not requested wrt bug #452760
	if ! [[ $(grep -i gperf Makefile.am | wc -l) -eq 27 ]]; then
			eerror "The line count for gperf references failed, see bug 452760"
			die
		fi
	fi

	# backport some patches
	if [[ -n "${patchset}" ]]; then
		EPATCH_SUFFIX=patch EPATCH_FORCE=yes epatch
	fi

	# These are missing from upstream 50-udev-default.rules
	cat <<-EOF > "${T}"/40-gentoo.rules
	# Gentoo specific usb group
	SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", GROUP="usb"
	# Keep this for Linux 2.6.32 kernels with accept4() support like .60 wrt #457868
	SUBSYSTEM=="mem", KERNEL=="null|zero|full|random|urandom", MODE="0666"
	EOF

	# Remove requirements for gettext and intltool wrt bug #443028
	if ! has_version dev-util/intltool && ! [[ ${PV} = 9999* ]]; then
		sed -i \
			-e '/INTLTOOL_APPLIED_VERSION=/s:=.*:=0.40.0:' \
			-e '/XML::Parser perl module is required for intltool/s|^|:|' \
			configure || die
		eval export INTLTOOL_{EXTRACT,MERGE,UPDATE}=/bin/true
		eval export {MSG{FMT,MERGE},XGETTEXT}=/bin/true
	fi

	# apply user patches
	epatch_user

	# compile with older versions of gcc #451110
	version_is_at_least 4.6 $(gcc-version) || \
		sed -i 's:static_assert:alsdjflkasjdfa:' src/shared/macro.h

	# change rules back to group uucp instead of dialout for now wrt #454556
	sed -e 's/GROUP="dialout"/GROUP="uucp"/' \
		-i rules/*.rules \
	|| die "failed to change group dialout to uucp"

	if [[ ! -e configure ]]; then
		if use doc; then
			gtkdocize --docdir docs || die "gtkdocize failed"
		else
			echo 'EXTRA_DIST =' > docs/gtk-doc.make
		fi
		eautoreconf
	else
		check_default_rules
		elibtoolize
	fi

	if ! use elibc_glibc; then #443030
		echo '#define secure_getenv(x) NULL' >> config.h.in
		sed -i -e '/error.*secure_getenv/s:.*:#define secure_getenv(x) NULL:' src/shared/missing.h || die
	fi

	# link udevd(8) to systemd-udevd.service(8) manpage
	echo '.so systemd-udevd.service.8' > "${T}"/udevd.8
}

src_configure() {
	use keymap || export ac_cv_path_GPERF=true #452760

	local econf_args

	econf_args=(
		ac_cv_search_cap_init=
		ac_cv_header_sys_capability_h=yes
		DBUS_CFLAGS=' '
		DBUS_LIBS=' '
		--bindir=/bin
		--docdir=/usr/share/doc/${PF}
		--libdir=/usr/$(get_libdir)
		--with-html-dir=/usr/share/doc/${PF}/html
		--with-rootprefix=
		--with-rootlibdir=/$(get_libdir)
		--with-bashcompletiondir=/usr/share/bash-completion
		--without-python
		--disable-audit
		--disable-coredump
		--disable-hostnamed
		--disable-ima
		--disable-libcryptsetup
		--disable-localed
		--disable-logind
		--disable-myhostname
		--disable-nls
		--disable-pam
		--disable-quotacheck
		--disable-readahead
		--enable-split-usr
		--disable-tcpwrap
		--disable-timedated
		--disable-xz
		--disable-silent-rules
		--disable-polkit
		$(use_enable acl)
		$(use_enable doc gtk-doc)
		$(use_enable gudev)
		$(use_enable keymap)
		$(use_enable kmod)
		$(use_enable selinux)
		$(use_enable static-libs static)
	)
	if use introspection; then
		econf_args+=(
			--enable-introspection=$(usex introspection)
		)
	fi
	econf "${econf_args[@]}"
}

src_compile() {
	echo 'BUILT_SOURCES: $(BUILT_SOURCES)' > "${T}"/Makefile.extra
	emake -f Makefile -f "${T}"/Makefile.extra BUILT_SOURCES
	local targets=(
		systemd-udevd
		udevadm
		libudev.la
		ata_id
		cdrom_id
		collect
		scsi_id
		v4l_id
		accelerometer
		mtd_probe
		man/udev.7
		man/udevadm.8
		man/systemd-udevd.8
		man/systemd-udevd.service.8
	)
	use keymap && targets+=( keymap )
	use gudev && targets+=( libgudev-1.0.la )

	emake "${targets[@]}"
	if use doc; then
		emake -C docs/libudev
		use gudev && emake -C docs/gudev
	fi
}

src_install() {
	local lib_LTLIBRARIES="libudev.la" \
		pkgconfiglib_DATA="src/libudev/libudev.pc"

	local targets=(
		install-libLTLIBRARIES
		install-includeHEADERS
		install-libgudev_includeHEADERS
		install-binPROGRAMS
		install-rootlibexecPROGRAMS
		install-udevlibexecPROGRAMS
		install-dist_systemunitDATA
		install-dist_udevconfDATA
		install-dist_udevhomeSCRIPTS
		install-dist_udevkeymapDATA
		install-dist_udevkeymapforcerelDATA
		install-dist_udevrulesDATA
		install-girDATA
		install-man3
		install-man7
		install-man8
		install-nodist_systemunitDATA
		install-pkgconfiglibDATA
		install-sharepkgconfigDATA
		install-typelibsDATA
		install-dist_docDATA
		libudev-install-hook
		install-directories-hook
		install-dist_bashcompletionDATA
	)

	if use gudev; then
		lib_LTLIBRARIES+=" libgudev-1.0.la"
		pkgconfiglib_DATA+=" src/gudev/gudev-1.0.pc"
	fi

	# add final values of variables:
	targets+=(
		rootlibexec_PROGRAMS=systemd-udevd
		bin_PROGRAMS=udevadm
		lib_LTLIBRARIES="${lib_LTLIBRARIES}"
		MANPAGES="man/udev.7 man/udevadm.8 \
				man/systemd-udevd.service.8"
		MANPAGES_ALIAS="man/systemd-udevd.8"
		dist_systemunit_DATA="units/systemd-udevd-control.socket \
				units/systemd-udevd-kernel.socket"
		nodist_systemunit_DATA="units/systemd-udevd.service \
				units/systemd-udev-trigger.service \
				units/systemd-udev-settle.service"
		pkgconfiglib_DATA="${pkgconfiglib_DATA}"
		systemunitdir="$(systemd_get_unitdir)"
		INSTALL_DIRS='$(sysconfdir)/udev/rules.d \
				$(sysconfdir)/udev/hwdb.d'
		dist_bashcompletion_DATA="shell-completion/bash/udevadm"
	)
	emake -j1 DESTDIR="${D}" "${targets[@]}"
	if use doc; then
		emake -C docs/libudev DESTDIR="${D}" install
		use gudev && emake -C docs/gudev DESTDIR="${D}" install
	fi
	dodoc TODO

	prune_libtool_files --all
	rm -f "${D}"/lib/udev/rules.d/99-systemd.rules
	rm -rf "${D}"/usr/share/doc/${PF}/LICENSE.*

	# install gentoo-specific rules
	insinto /lib/udev/rules.d
	doins "${T}"/40-gentoo.rules

	# install udevadm symlink
	dosym ../bin/udevadm /sbin/udevadm

	# move udevd where it should be and remove unlogical /lib/systemd
	mv "${ED}"/lib/systemd/systemd-udevd "${ED}"/sbin/udevd || die
	rm -r "${ED}"/lib/systemd

	# install compability symlink for systemd and initramfs tools
	dosym /sbin/udevd "$(systemd_get_utildir)"/systemd-udevd
	find "${ED}/$(systemd_get_unitdir)" -name '*.service' -exec \
		sed -i -e "/ExecStart/s:/lib/systemd:$(systemd_get_utildir):" {} +

	# see src_prepare() where this is created
	doman "${T}"/udevd.8
}

pkg_preinst() {
	local htmldir
	for htmldir in gudev libudev; do
		if [[ -d ${ROOT}usr/share/gtk-doc/html/${htmldir} ]]; then
			rm -rf "${ROOT}"usr/share/gtk-doc/html/${htmldir}
		fi
		if [[ -d ${D}/usr/share/doc/${PF}/html/${htmldir} ]]; then
			dosym ../../doc/${PF}/html/${htmldir} \
				/usr/share/gtk-doc/html/${htmldir}
		fi
	done
	preserve_old_lib /{,usr/}$(get_libdir)/libudev$(get_libname 0)
}

# This function determines if a directory is a mount point.
# It was lifted from dracut.
ismounted() {
	while read a m a; do
		[[ $m = $1 ]] && return 0
	done < "${ROOT}"/proc/mounts
	return 1
}

pkg_postinst() {
	mkdir -p "${ROOT}"run

	# "losetup -f" is confused if there is an empty /dev/loop/, Bug #338766
	# So try to remove it here (will only work if empty).
	rmdir "${ROOT}"dev/loop 2>/dev/null
	if [[ -d ${ROOT}dev/loop ]]; then
		ewarn "Please make sure your remove /dev/loop,"
		ewarn "else losetup may be confused when looking for unused devices."
	fi

	# people want reminders, I'll give them reminders.  Odds are they will
	# just ignore them anyway...

	# 64-device-mapper.rules is related to sys-fs/device-mapper which we block
	# in favor of sys-fs/lvm2
	old_dm_rules=${ROOT}etc/udev/rules.d/64-device-mapper.rules
	if [[ -f ${old_dm_rules} ]]; then
		rm -f "${old_dm_rules}"
		einfo "Removed unneeded file ${old_dm_rules}"
	fi

	if ismounted /usr; then
		ewarn
		ewarn "Your system has /usr on a separate partition. This means"
		ewarn "you will need to use an initramfs to pre-mount /usr before"
		ewarn "udev runs."
		ewarn
		ewarn "If this is not set up before your next reboot, udev may work;"
		ewarn "However, you also may experience failures which are very"
		ewarn "difficult to troubleshoot."
		ewarn
		ewarn "For a more detailed explanation, see the following URL:"
		ewarn "http://www.freedesktop.org/wiki/Software/systemd/separate-usr-is-broken"
		ewarn
		ewarn "For more information on setting up an initramfs, see the"
		ewarn "following URL:"
		ewarn "http://www.gentoo.org/doc/en/initramfs-guide.xml"
	fi

	local fstab="${ROOT}"etc/fstab dev path fstype rest
	while read -r dev path fstype rest; do
		if [[ ${path} == /dev && ${fstype} != devtmpfs ]]; then
			ewarn "You need to edit your /dev line in ${fstab} to have devtmpfs"
			ewarn "filesystem. Otherwise udev won't be able to boot."
			ewarn "See, http://bugs.gentoo.org/453186"
		fi
	done < "${fstab}"

	if [[ -d ${ROOT}usr/lib/udev ]]; then
		ewarn
		ewarn "Please re-emerge all packages on your system which install"
		ewarn "rules and helpers in /usr/lib/udev. They should now be in"
		ewarn "/lib/udev."
		ewarn
		ewarn "One way to do this is to run the following command:"
		ewarn "emerge -av1 \$(qfile -q -S -C /usr/lib/udev)"
		ewarn "Note that qfile can be found in app-portage/portage-utils"
	fi

	local old_net_name="${ROOT}"etc/udev/rules.d/80-net-name-slot.rules
	if [[ -f ${old_net_name} ]]; then
		local old_net_sum=bebf4bd1b6b668e9ff34a3999aa6ff32
		MD5=$(md5sum < "${old_net_name}")
		MD5=${MD5/  -/}
		if [[ ${MD5} == ${old_net_sum} ]]; then
			ewarn "Removing unmodified file ${old_net_name} from old udev installation to enable"
			ewarn "the new predictable network interface naming."
			rm -f "${old_net_name}"
		fi
	fi

	local old_cd_rules="${ROOT}"etc/udev/rules.d/70-persistent-cd.rules
	local old_net_rules="${ROOT}"etc/udev/rules.d/70-persistent-net.rules
	for old_rules in "${old_cd_rules}" "${old_net_rules}"; do
		if [[ -f ${old_rules} ]]; then
			ewarn
			ewarn "File ${old_rules} is from old udev installation but if you still use it,"
			ewarn "rename it to something else starting with 70- to silence this deprecation"
			ewarn "warning."
		fi
	done

	if has_version sys-apps/biosdevname; then
		ewarn
		ewarn "You have sys-apps/biosdevname installed which has been deprecated"
		ewarn "in favor of the predictable network interface names."
	fi

	ewarn
	ewarn "The new predictable network interface names are used by default, see:"
	ewarn "http://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames"
	ewarn
	ewarn "Example command to get the information for the new interface name before booting"
	ewarn "(replace ifname with, for example, eth0):"
	ewarn "# udevadm test-builtin net_id /sys/class/net/<ifname> 2> /dev/null"

	ewarn
	ewarn "You need to restart udev as soon as possible to make the upgrade go"
	ewarn "into effect."
	ewarn "The method you use to do this depends on your init system."

	preserve_old_lib_notify /{,usr/}$(get_libdir)/libudev$(get_libname 0)

	elog
	elog "For more information on udev on Gentoo, writing udev rules, and"
	elog "         fixing known issues visit:"
	elog "         http://www.gentoo.org/doc/en/udev-guide.xml"

	# Keep this here in case the database format changes so it gets updated
	# when required. Despite that this file is owned by sys-apps/hwids.
	if use hwdb && has_version sys-apps/hwids; then
		udevadm hwdb --update --root="${ROOT%/}"
	fi
}
