# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/evms/evms-2.5.5-r13.ebuild,v 1.4 2012/05/24 04:17:33 vapier Exp $

EAPI=4

inherit autotools-utils flag-o-matic toolchain-funcs linux-info eutils

PATCHVER="${PV}-4"

DESCRIPTION="Utilities for the IBM Enterprise Volume Management System"
HOMEPAGE="http://www.sourceforge.net/projects/evms"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz mirror://gentoo/${PN}-patches-${PATCHVER}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="ncurses nls"

# sys-apps/util-linux: libuuid
# sys-libs/readline: evms cli
RDEPEND="
	sys-apps/util-linux
	sys-libs/readline
	|| (
		sys-fs/device-mapper
		>=sys-fs/lvm2-2.02.45
	)
	ncurses? (
		>=dev-libs/glib-2.12.4-r1
		sys-libs/ncurses
	)
"
DEPEND="${RDEPEND}
	ncurses? ( virtual/pkgconfig )
"

# While the test-concept holds, many of them fail due to unknown reasons.
# Since upstream is almost dead, we have to ignore that for now.
RESTRICT="test"

AUTOTOOLS_IN_SOURCE_BUILD=1

pkg_setup() {
	get_running_version
	if [[ ${KV_MAJOR} -eq 2 ]]; then
		if [[ ${KV_PATCH} -lt 19 ]] || [[ ${KV_MINOR} -eq 4 ]]; then
			ewarn "This revision of EVMS may not work correctly with kernels prior to 2.6.19 when"
			ewarn "using snapshots due to API changes. Please update your kernel or use EVMS 2.5.5-r9."
			ebeep 5
		fi
	fi
}

src_prepare() {
	EPATCH_SOURCE="${WORKDIR}/patches"
	EPATCH_SUFFIX="patch"
	epatch
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	# Bug #54856
	# filter-flags "-fstack-protector"
	replace-flags -O3 -O2
	replace-flags -Os -O2

	myeconfargs+=(
		--disable-ha
		--disable-hb2
		--disable-gui
		--enable-cli
		--without-debug
		$(use_enable ncurses text-mode)
		$(use_enable nls)
	)

	autotools-utils_src_configure
}

src_install() {
	DOCS=(ChangeLog INSTALL* PLUGIN.IDS README TERMINOLOGY)
	autotools-utils_src_install

	# Remove static libs
	find "${D}" -name '*.a' -exec rm -f {} + || die

	# the kernel patches may come handy for people compiling their own kernel
	docinto kernel/2.4
	dodoc kernel/2.4/*
	docinto kernel/2.6
	dodoc kernel/2.6/*
}

src_test() {
	if [[ -z ${EVMS_TEST_VOLUME} ]] ; then
		eerror "This is a volume manager and it therefore needs a volume"
		eerror "for testing. You have to define EVMS_TEST_VOLUME as"
		eerror "a volume evms can operate on."
		eerror "Example: export EVMS_TEST_VOLUME=sda"
		eerror "Note: The volume-name can not be a symlink."
		eerror "WARNING: EVMS WILL DESTROY EVERYTHING ON IT."
		einfo "If you don't have an empty disk, you can use the loopback-device:"
		einfo "- Create a large file using dd (this creates a 4GB file):"
		einfo "  dd if=/dev/zero of=/tmp/evms_test_file bs=1M count=4096"
		einfo "- Activate a loop device on this file:"
		einfo "  losetup /dev/loop0 /tmp/evms_test_file"
		einfo "- export EVMS_TEST_VOLUME=loop0"
		einfo "The disk has to be at least 4GB!"
		einfo "To deactivate the loop-device afterwards:"
		einfo "- losetup -d /dev/loop0"
		has userpriv ${FEATURES} && ewarn "These tests have to run as root. Disable userpriv!"
		die "need test-volume"
	fi

	if has userpriv ${FEATURES} ; then
		eerror "These tests need root privileges. Disable userpriv!"
		die "userpriv is not supported"
	fi

	einfo "Disabling sandbox for:"
	einfo " - /dev/${EVMS_TEST_VOLUME}"
	addwrite /dev/${EVMS_TEST_VOLUME}
	einfo " - /dev/evms"
	addwrite /dev/evms
	einfo " - /var/lock/evms-engine"
	addwrite /var/lock/evms-engine

	cd "${S}/tests/suite"
	PATH="${S}/ui/cli:${S}/tests:/sbin:/usr/sbin:${PATH}" ./run_tests ${EVMS_TEST_VOLUME} || die "tests failed"
}

pkg_postinst() {
	elog "This version of EVMS is meant for data migration and"
	elog "disk maintenance only. Auto-activating EVMS volumes (i.e. for booting"
	elog "purpose) is no longer supported."
	elog "Please use this package to migrate to LVM2"
}
