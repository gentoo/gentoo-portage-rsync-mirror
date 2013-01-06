# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-141-r1.ebuild,v 1.9 2012/07/31 04:43:38 ssuominen Exp $

#
# Please do not remove this version:
#   It is the highest version that works with xen-sources
#

EAPI="1"

inherit eutils flag-o-matic multilib toolchain-funcs versionator

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/hotplug/udev.git"
	EGIT_BRANCH="master"
	inherit git-2 autotools
else
	SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.bz2
		http://dev.gentoo.org/~ssuominen/${PN}-gentoo-legacy-patchset-1.tar.bz2"
fi
DESCRIPTION="Linux dynamic and persistent device naming support (aka userspace devfs)"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="selinux +devfs-compat"

COMMON_DEPEND="selinux? ( sys-libs/libselinux )"

if [[ ${PV} == "9999" ]]; then
	# for documentation processing with xsltproc
	DEPEND="${COMMON_DEPEND}
		app-text/docbook-xsl-stylesheets
		app-text/docbook-xml-dtd"
else
	DEPEND="${COMMON_DEPEND}"
fi

RDEPEND="${COMMON_DEPEND}
	!sys-apps/coldplug
	!<sys-fs/device-mapper-1.02.19-r1
	>=sys-apps/baselayout-1.12.5"

pkg_setup() {
	udev_helper_dir="/$(get_libdir)/udev"

	# comparing kernel version without linux-info.eclass to not pull
	# virtual/linux-sources

	local KV=$(uname -r)
	local KV_MAJOR=$(get_major_version ${KV})
	local KV_MINOR=$(get_version_component_range 2 ${KV})
	local KV_MICRO=$(get_version_component_range 3 ${KV})

	local KV_min_micro=15 KV_min_micro_reliable=22
	KV_min=2.6.${KV_min_micro}
	KV_min_reliable=2.6.${KV_min_micro_reliable}

	local ok=0
	if [[ ${KV_MAJOR} == 2 && ${KV_MINOR} == 6 ]]
	then
		if [[ ${KV_MICRO} -ge ${KV_min_micro_reliable} ]]; then
			ok=2
		elif [[ ${KV_MICRO} -ge ${KV_min_micro} ]]; then
			ok=1
		fi
	fi

	if [[ ${ok} -lt 1 ]]
	then
		ewarn
		ewarn "${P} does not support Linux kernel before version ${KV_min}!"
	fi
	if [[ ${ok} -lt 2 ]]; then
		ewarn "If you want to use udev reliable you should update"
		ewarn "to at least kernel version ${KV_min_reliable}!"
		ewarn
		ebeep
	fi
}

sed_helper_dir() {
	sed -e "s#/lib/udev#${udev_helper_dir}#" -i "$@"
}

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack ${A}
	fi

	cd "${S}"

	# patches go here...
	if ! use devfs-compat; then
		# see Bug #269359
		epatch "${WORKDIR}"/udev-141-remove-devfs-names.diff
	fi

	# change rules back to group uucp instead of dialout for now
	sed -e 's/GROUP="dialout"/GROUP="uucp"/' \
		-i rules/{rules.d,packages,gentoo}/*.rules \
	|| die "failed to change group dialout to uucp"

	if [[ ${PV} != 9999 ]]; then
		# Make sure there is no sudden changes to upstream rules file
		# (more for my own needs than anything else ...)
		MD5=$(md5sum < "${S}/rules/rules.d/50-udev-default.rules")
		MD5=${MD5/  -/}
		if [[ ${MD5} != b5c2f014a48a53921de37c4e469aab96 ]]
		then
			echo
			eerror "50-udev-default.rules has been updated, please validate!"
			eerror "md5sum=${MD5}"
			die "50-udev-default.rules has been updated, please validate!"
		fi
	fi

	sed_helper_dir \
		rules/rules.d/50-udev-default.rules \
		extras/rule_generator/write_*_rules \
		udev/udev-util.c \
		udev/udev-rules.c \
		udev/udevd.c || die "sed failed"

	if [[ ${PV} == 9999 ]]; then
		eautoreconf
	fi
}

src_compile() {
	filter-flags -fprefetch-loop-arrays

	econf \
		--prefix=/usr \
		--sysconfdir=/etc \
		--exec-prefix= \
		--with-libdir-name=$(get_libdir) \
		--enable-logging \
		$(use_with selinux)

	emake || die "compiling udev failed"
}

src_install() {
	local scriptdir="${WORKDIR}/136"

	into /
	emake DESTDIR="${D}" install || die "make install failed"
	if [[ "$(get_libdir)" != "lib" ]]; then
		# we can not just rename /lib to /lib64, because
		# make install creates /lib64 and /lib
		mkdir -p "${D}/$(get_libdir)"
		mv "${D}"/lib/* "${D}/$(get_libdir)/"
		rmdir "${D}"/lib
	fi

	exeinto "${udev_helper_dir}"
	newexe "${WORKDIR}"/net-130-r1.sh net.sh	|| die "net.sh not installed properly"
	newexe "${WORKDIR}"/move_tmp_persistent_rules-112-r1.sh move_tmp_persistent_rules.sh \
		|| die "move_tmp_persistent_rules.sh not installed properly"
	newexe "${WORKDIR}"/write_root_link_rule-125 write_root_link_rule \
		|| die "write_root_link_rule not installed properly"

	doexe "${scriptdir}"/shell-compat-KV.sh \
		|| die "shell-compat.sh not installed properly"
	doexe "${scriptdir}"/shell-compat-addon.sh \
		|| die "shell-compat.sh not installed properly"

	keepdir "${udev_helper_dir}"/state
	keepdir "${udev_helper_dir}"/devices

	# create symlinks for these utilities to /sbin
	# where multipath-tools expect them to be (Bug #168588)
	dosym "..${udev_helper_dir}/vol_id" /sbin/vol_id
	dosym "..${udev_helper_dir}/scsi_id" /sbin/scsi_id

	# Add gentoo stuff to udev.conf
	echo "# If you need to change mount-options, do it in /etc/fstab" \
	>> "${D}"/etc/udev/udev.conf

	# let the dir exist at least
	keepdir /etc/udev/rules.d

	# Now installing rules
	cd "${S}"/rules
	insinto "${udev_helper_dir}"/rules.d/

	# Our rules files
	doins gentoo/??-*.rules
	doins packages/40-alsa.rules
	doins packages/40-isdn.rules

	# Adding arch specific rules
	if [[ -f packages/40-${ARCH}.rules ]]
	then
		doins "packages/40-${ARCH}.rules"
	fi
	cd "${S}"

	# our udev hooks into the rc system
	insinto /$(get_libdir)/rcscripts/addons
	doins "${scriptdir}"/udev-start.sh \
		|| die "udev-start.sh not installed properly"
	doins "${scriptdir}"/udev-stop.sh \
		|| die "udev-stop.sh not installed properly"

	local init
	# udev-postmount and init-scripts for >=openrc-0.3.1, Bug #240984
	for init in udev udev-mount udev-dev-tarball udev-postmount; do
		newinitd "${scriptdir}/${init}.initd" "${init}" \
			|| die "initscript ${init} not installed properly"
	done

	# insert minimum kernel versions
	sed -e "s/%KV_MIN%/${KV_min}/" \
		-e "s/%KV_MIN_RELIABLE%/${KV_min_reliable}/" \
		-i "${D}"/etc/init.d/udev-mount

	# config file for init-script and start-addon
	newconfd "${scriptdir}/udev.confd" udev \
		|| die "config file not installed properly"

	insinto /etc/modprobe.d
	newins "${WORKDIR}"/blacklist-146 blacklist.conf
	newins "${WORKDIR}"/pnp-aliases pnp-aliases.conf

	# convert /lib/udev to real used dir
	sed_helper_dir \
		"${D}/$(get_libdir)"/rcscripts/addons/*.sh \
		"${D}"/etc/init.d/udev* \
		"${D}"/etc/modprobe.d/*

	# documentation
	dodoc ChangeLog README TODO || die "failed installing docs"

	cd docs/writing_udev_rules
	mv index.html writing_udev_rules.html
	dohtml *.html

	cd "${S}"

	newdoc extras/volume_id/README README_volume_id

	echo "CONFIG_PROTECT_MASK=\"/etc/udev/rules.d\"" > 20udev
	doenvd 20udev
}

pkg_preinst() {
	local f dir=${ROOT}/etc/modprobe.d/
	for f in pnp-aliases blacklist; do
		if [[ -f $dir/$f && ! -f $dir/$f.conf ]]
		then
			elog "Moving $dir/$f to $f.conf"
			mv -f "$dir/$f" "$dir/$f.conf"
		fi
	done

	if [[ -d ${ROOT}/lib/udev-state ]]
	then
		mv -f "${ROOT}"/lib/udev-state/* "${D}"/lib/udev/state/
		rm -r "${ROOT}"/lib/udev-state
	fi

	if [[ -f ${ROOT}/etc/udev/udev.config &&
	     ! -f ${ROOT}/etc/udev/udev.rules ]]
	then
		mv -f "${ROOT}"/etc/udev/udev.config "${ROOT}"/etc/udev/udev.rules
	fi

	# delete the old udev.hotplug symlink if it is present
	if [[ -h ${ROOT}/etc/hotplug.d/default/udev.hotplug ]]
	then
		rm -f "${ROOT}"/etc/hotplug.d/default/udev.hotplug
	fi

	# delete the old wait_for_sysfs.hotplug symlink if it is present
	if [[ -h ${ROOT}/etc/hotplug.d/default/05-wait_for_sysfs.hotplug ]]
	then
		rm -f "${ROOT}"/etc/hotplug.d/default/05-wait_for_sysfs.hotplug
	fi

	# delete the old wait_for_sysfs.hotplug symlink if it is present
	if [[ -h ${ROOT}/etc/hotplug.d/default/10-udev.hotplug ]]
	then
		rm -f "${ROOT}"/etc/hotplug.d/default/10-udev.hotplug
	fi

	# is there a stale coldplug initscript? (CONFIG_PROTECT leaves it behind)
	coldplug_stale=""
	if [[ -f ${ROOT}/etc/init.d/coldplug ]]
	then
		coldplug_stale="1"
	fi

	has_version "=${CATEGORY}/${PN}-103-r3"
	previous_equal_to_103_r3=$?

	has_version "<${CATEGORY}/${PN}-104-r5"
	previous_less_than_104_r5=$?

	has_version "<${CATEGORY}/${PN}-106-r5"
	previous_less_than_106_r5=$?

	has_version "<${CATEGORY}/${PN}-113"
	previous_less_than_113=$?
}

fix_old_persistent_net_rules() {
	local rules=${ROOT}/etc/udev/rules.d/70-persistent-net.rules
	[[ -f ${rules} ]] || return

	elog
	elog "Updating persistent-net rules file"

	# Change ATTRS to ATTR matches, Bug #246927
	sed -i -e 's/ATTRS{/ATTR{/g' "${rules}"

	# Add KERNEL matches if missing, Bug #246849
	sed -ri \
		-e '/KERNEL/ ! { s/NAME="(eth|wlan|ath)([0-9]+)"/KERNEL=="\1*", NAME="\1\2"/}' \
		"${rules}"
}

# See Bug #129204 for a discussion about restarting udevd
restart_udevd() {
	# need to merge to our system
	[[ ${ROOT} = / ]] || return

	# check if root of init-process is identical to ours (not in chroot)
	[[ -r /proc/1/root && /proc/1/root/ -ef /proc/self/root/ ]] || return

	# abort if there is no udevd running
	[[ -n $(pidof udevd) ]] || return

	# abort if no /dev/.udev exists
	[[ -e /dev/.udev ]] || return

	elog
	elog "restarting udevd now."

	killall -15 udevd &>/dev/null
	sleep 1
	killall -9 udevd &>/dev/null

	/sbin/udevd --daemon
}

pkg_postinst() {
	fix_old_persistent_net_rules

	restart_udevd

	if [[ -e "${ROOT}"/etc/runlevels/sysinit && ! -e "${ROOT}"/etc/runlevels/sysinit/udev ]]
	then
		ewarn
		ewarn "You need to add the udev init script to the runlevel sysinit,"
		ewarn "else your system will not be able to boot"
		ewarn "after updating to >=openrc-0.4.0"
		ewarn "Run this to enable udev for >=openrc-0.4.0:"
		ewarn "\trc-update add udev sysinit"
		ewarn
	fi

	# people want reminders, I'll give them reminders.  Odds are they will
	# just ignore them anyway...

	if [[ ${coldplug_stale} == 1 ]]
	then
		ewarn "A stale coldplug init script found. You should run:"
		ewarn
		ewarn "      rc-update del coldplug"
		ewarn "      rm -f /etc/init.d/coldplug"
		ewarn
		ewarn "udev now provides its own coldplug functionality."
	fi

	# delete 40-scsi-hotplug.rules - all integrated in 50-udev.rules
	if [[ $previous_equal_to_103_r3 = 0 ]] &&
		[[ -e ${ROOT}/etc/udev/rules.d/40-scsi-hotplug.rules ]]
	then
		ewarn "Deleting stray 40-scsi-hotplug.rules"
		ewarn "installed by sys-fs/udev-103-r3"
		rm -f "${ROOT}"/etc/udev/rules.d/40-scsi-hotplug.rules
	fi

	# Removing some device-nodes we thought we need some time ago
	if [[ -d ${ROOT}/lib/udev/devices ]]
	then
		rm -f "${ROOT}"/lib/udev/devices/{null,zero,console,urandom}
	fi

	# Removing some old file
	if [[ $previous_less_than_104_r5 = 0 ]]
	then
		rm -f "${ROOT}"/etc/dev.d/net/hotplug.dev
		rmdir --ignore-fail-on-non-empty "${ROOT}"/etc/dev.d/net 2>/dev/null
	fi

	if [[ $previous_less_than_106_r5 = 0 ]] &&
		[[ -e ${ROOT}/etc/udev/rules.d/95-net.rules ]]
	then
		rm -f "${ROOT}"/etc/udev/rules.d/95-net.rules
	fi

	# Try to remove /etc/dev.d as that is obsolete
	if [[ -d ${ROOT}/etc/dev.d ]]
	then
		rmdir --ignore-fail-on-non-empty "${ROOT}"/etc/dev.d/default "${ROOT}"/etc/dev.d 2>/dev/null
		if [[ -d ${ROOT}/etc/dev.d ]]
		then
			ewarn "You still have the directory /etc/dev.d on your system."
			ewarn "This is no longer used by udev and can be removed."
		fi
	fi

	# 64-device-mapper.rules now gets installed by sys-fs/device-mapper
	# remove it if user don't has sys-fs/device-mapper installed
	if [[ $previous_less_than_113 = 0 ]] &&
		[[ -f ${ROOT}/etc/udev/rules.d/64-device-mapper.rules ]] &&
		! has_version sys-fs/device-mapper
	then
			rm -f "${ROOT}"/etc/udev/rules.d/64-device-mapper.rules
			einfo "Removed unneeded file 64-device-mapper.rules"
	fi

	# requested in Bug #225033:
	elog
	elog "persistent-net does assigning fixed names to network devices."
	elog "If you have problems with the persistent-net rules,"
	elog "just delete the rules file"
	elog "\trm ${ROOT}etc/udev/rules.d/70-persistent-net.rules"
	elog "and then reboot."
	elog
	elog "This may however number your devices in a different way than they are now."

	ewarn
	ewarn "If you build an initramfs including udev, then please"
	ewarn "make sure that the /sbin/udevadm binary gets included,"
	ewarn "and your scripts changed to use it,as it replaces the"
	ewarn "old helper apps udevinfo, udevtrigger, ..."

	ewarn
	ewarn "mount options for directory /dev are no longer"
	ewarn "set in /etc/udev/udev.conf, but in /etc/fstab"
	ewarn "as for other directories."

	if use devfs-compat; then
		ewarn
		ewarn "devfs-compat use flag is enabled (by default)."
		ewarn "This enables devfs compatible device names."
		ewarn "If you use /dev/md/*, /dev/loop/* or /dev/rd/*,"
		ewarn "then please migrate over to using the device names"
		ewarn "/dev/md*, /dev/loop* and /dev/ram*."
		ewarn "The devfs-compat rules will be removed in the future."
		ewarn "For reference see Bug #269359."
	fi

	elog
	elog "For more information on udev on Gentoo, writing udev rules, and"
	elog "         fixing known issues visit:"
	elog "         http://www.gentoo.org/doc/en/udev-guide.xml"
}
