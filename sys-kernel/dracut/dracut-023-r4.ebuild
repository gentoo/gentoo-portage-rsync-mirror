# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/dracut/dracut-023-r4.ebuild,v 1.5 2013/04/09 10:09:20 ssuominen Exp $

EAPI=4

inherit eutils linux-info toolchain-funcs

add_req_use_for() {
	local dep="$1"; shift
	local f

	for f in "$@"; do
		REQUIRED_USE+="${f}? ( ${dep} )
"
	done
}

DESCRIPTION="Generic initramfs generation tool"
HOMEPAGE="http://dracut.wiki.kernel.org"
SRC_URI="mirror://kernel/linux/utils/boot/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE="dracut_modules_crypt-gpg? ( dracut_modules_crypt )
	dracut_modules_crypt-loop? ( dracut_modules_crypt )
	dracut_modules_livenet? ( dracut_modules_dmsquash-live )
	"
COMMON_MODULES="
	dracut_modules_biosdevname
	dracut_modules_bootchart
	dracut_modules_btrfs
	dracut_modules_caps
	dracut_modules_crypt-gpg
	dracut_modules_crypt-loop
	dracut_modules_gensplash
	dracut_modules_mdraid
	dracut_modules_multipath
	dracut_modules_plymouth
	dracut_modules_syslog
	dracut_modules_systemd
	"
DM_MODULES="
	dracut_modules_crypt
	dracut_modules_dmraid
	dracut_modules_dmsquash-live
	dracut_modules_livenet
	dracut_modules_lvm
	"
NETWORK_MODULES="
	dracut_modules_cifs
	dracut_modules_iscsi
	dracut_modules_livenet
	dracut_modules_nbd
	dracut_modules_nfs
	dracut_modules_ssh-client
	"
add_req_use_for device-mapper ${DM_MODULES}
add_req_use_for net ${NETWORK_MODULES}
IUSE_DRACUT_MODULES="${COMMON_MODULES} ${DM_MODULES} ${NETWORK_MODULES}"
IUSE="debug device-mapper optimization net selinux ${IUSE_DRACUT_MODULES}"

RESTRICT="test"

CDEPEND="virtual/udev
	dracut_modules_systemd? ( sys-apps/systemd )
	"
RDEPEND="${CDEPEND}
	app-arch/cpio
	>=app-shells/bash-4.0
	>=app-shells/dash-0.5.4.11
	>=sys-apps/baselayout-1.12.14-r1
	|| ( >=sys-apps/module-init-tools-3.8 >sys-apps/kmod-5[tools] )
	>=sys-apps/sysvinit-2.87-r3
	>=sys-apps/util-linux-2.21

	debug? ( dev-util/strace )
	device-mapper? ( >=sys-fs/lvm2-2.02.33 )
	net? ( net-misc/curl >=net-misc/dhcp-4.2.4_p2-r1[client] sys-apps/iproute2 )
	selinux? ( sys-libs/libselinux sys-libs/libsepol )
	dracut_modules_biosdevname? ( sys-apps/biosdevname )
	dracut_modules_bootchart? ( app-benchmarks/bootchart2 sys-apps/usleep
		sys-process/acct )
	dracut_modules_btrfs? ( sys-fs/btrfs-progs )
	dracut_modules_caps? ( sys-libs/libcap )
	dracut_modules_cifs? ( net-fs/cifs-utils )
	dracut_modules_crypt? ( sys-fs/cryptsetup )
	dracut_modules_crypt-gpg? ( app-crypt/gnupg )
	dracut_modules_dmraid? ( sys-fs/dmraid sys-fs/multipath-tools )
	dracut_modules_gensplash? ( media-gfx/splashutils )
	dracut_modules_iscsi? ( >=sys-block/open-iscsi-2.0.871.3 )
	dracut_modules_lvm? ( >=sys-fs/lvm2-2.02.33 )
	dracut_modules_mdraid? ( sys-fs/mdadm )
	dracut_modules_multipath? ( sys-fs/multipath-tools )
	dracut_modules_nbd? ( sys-block/nbd )
	dracut_modules_nfs? ( net-fs/nfs-utils net-nds/rpcbind )
	dracut_modules_plymouth? ( >=sys-boot/plymouth-0.8.3-r1 )
	dracut_modules_ssh-client? ( dev-libs/openssl )
	dracut_modules_syslog? ( || ( app-admin/syslog-ng app-admin/rsyslog ) )
	"
DEPEND="${CDEPEND}
	app-text/asciidoc
	>=dev-libs/libxslt-1.1.26
	app-text/docbook-xml-dtd:4.5
	>=app-text/docbook-xsl-stylesheets-1.75.2
	virtual/pkgconfig
	"

#
# Helper functions
#

# Returns true if any of specified modules is enabled by USE flag and false
# otherwise.
# $1 = list of modules (which have corresponding USE flags of the same name)
any_module() {
	local m modules=" $@ "

	for m in ${modules}; do
		! use $m && modules=${modules/ $m / }
	done

	shopt -s extglob
	modules=${modules%%+( )}
	shopt -u extglob

	[[ ${modules} ]]
}

# Removes module from modules.d.
# $1 = module name
# Module name can be specified without number prefix.
rm_module() {
	local force m
	[[ $1 = -f ]] && force=-f

	for m in $@; do
		if [[ $m =~ ^[0-9][0-9][^\ ]*$ ]]; then
			rm ${force} --interactive=never -r "${modules_dir}"/$m
		else
			rm ${force} --interactive=never -r "${modules_dir}"/[0-9][0-9]$m
		fi
	done
}

#
# ebuild functions
#

src_prepare() {
	epatch "${FILESDIR}/${PV}-0001-dracut-functions.sh-find_binary-path-s.patch"
	epatch "${FILESDIR}/${PV}-0002-90crypt-call-systemd-commands-only-if-.patch"
	epatch "${FILESDIR}/${PV}-0003-Fallback-to-external-blkid-and-path_id.patch"
	chmod +x "${S}/modules.d/95udev-rules/udev-rules-prepare.sh"

	local udevdir="$($(tc-getPKG_CONFIG) udev --variable=udevdir)"
	[[ ${udevdir} ]] || die "Couldn't detect udevdir"
	einfo "Setting udevdir to ${udevdir}..."
	sed -e "s@udevdir=.*@udevdir=\"${udevdir}\"@" \
		-i "${S}/dracut.conf.d/gentoo.conf.example" || die

	if use dracut_modules_systemd; then
		local systemdutildir="$($(tc-getPKG_CONFIG) systemd \
			--variable=systemdutildir)"
		local systemdsystemunitdir="$($(tc-getPKG_CONFIG) systemd \
			--variable=systemdsystemunitdir)"
		[[ ${systemdutildir} ]] || die "Couldn't detect systemdutildir"
		[[ ${systemdsystemunitdir} ]] \
			|| die "Couldn't detect systemdsystemunitdir"
		einfo "Setting systemdutildir to ${systemdutildir} and ..."
		sed -e "4asystemdutildir=\"${systemdutildir}\"" \
			-i "${S}/dracut.conf.d/gentoo.conf.example" || die
		einfo "Setting systemdsystemunitdir to ${systemdsystemunitdir}..."
		sed -e "5asystemdsystemunitdir=\"${systemdsystemunitdir}\"" \
			-i "${S}/dracut.conf.d/gentoo.conf.example" || die
	fi
}

src_compile() {
	emake prefix=/usr sysconfdir=/etc DESTDIR="${D}" doc
	if use optimization; then
		ewarn "Enabling experimental optimization!"
		tc-export CC
		emake prefix=/usr sysconfdir=/etc DESTDIR="${D}" install/dracut-install
	fi
}

src_install() {
	local libdir="/usr/lib"

	emake prefix=/usr libdir="${libdir}" sysconfdir=/etc \
		DESTDIR="${D}" install

	dodir /var/lib/dracut/overlay
	dodoc HACKING TODO AUTHORS NEWS README*

	insinto /etc/dracut.conf.d
	newins dracut.conf.d/gentoo.conf.example gentoo.conf

	insinto /etc/logrotate.d
	newins dracut.logrotate dracut

	dohtml dracut.html

	#
	# Modules
	#
	local module
	modules_dir="${D%/}/${libdir#/}/dracut/modules.d"

	# Remove modules not enabled by USE flags
	for module in ${IUSE_DRACUT_MODULES} ; do
		! use ${module} && rm_module -f ${module#dracut_modules_}
	done

	# Those flags are specific, and even are corresponding to modules, they need
	# to be declared as regular USE flags.
	use debug || rm_module 95debug
	use selinux || rm_module 98selinux

	# Following flags define set of helper modules which are base dependencies
	# for others and as so have no practical use, so remove these modules.
	use device-mapper  || rm_module 90dm
	use net || rm_module 40network 45ifcfg 45url-lib

	# Remove S/390 modules which are not tested at all
	rm_module 80cms 95dasd 95dasd_mod 95zfcp 95znet

	# Remove modules which won't work for sure
	rm_module 95fcoe # no tools
	# fips module depends on masked app-crypt/hmaccalc
	rm_module 01fips 02fips-aesni

	# Remove extra modules which go to future dracut-extras
	rm_module 05busybox 97masterkey 98ecryptfs 98integrity
}

pkg_postinst() {
	if linux-info_get_any_version && linux_config_src_exists; then
		ewarn ""
		ewarn "If the following test report contains a missing kernel"
		ewarn "configuration option, you should reconfigure and rebuild your"
		ewarn "kernel before booting image generated with this Dracut version."
		ewarn ""

		local CONFIG_CHECK="~BLK_DEV_INITRD ~DEVTMPFS ~MODULES"

		# Kernel configuration options descriptions:
		local desc_DEVTMPFS="Maintain a devtmpfs filesystem to mount at /dev"
		local desc_BLK_DEV_INITRD="Initial RAM filesystem and RAM disk "\
"(initramfs/initrd) support"
		local desc_MODULES="Enable loadable module support"

		local opt desc

		# Generate ERROR_* variables for check_extra_config.
		for opt in ${CONFIG_CHECK}; do
			opt=${opt#\~}
			desc=desc_${opt}
			eval "local ERROR_${opt}='CONFIG_${opt}: \"${!desc}\"" \
				"is missing and REQUIRED'"
		done

		check_extra_config
		echo
	else
		ewarn ""
		ewarn "Your kernel configuration couldn't be checked.  Do you have"
		ewarn "/usr/src/linux/.config file there?  Please check manually if"
		ewarn "following options are enabled:"
		ewarn ""
		ewarn "  CONFIG_BLK_DEV_INITRD"
		ewarn "  CONFIG_DEVTMPFS"
		ewarn "  CONFIG_MODULES"
		ewarn ""
	fi
}
