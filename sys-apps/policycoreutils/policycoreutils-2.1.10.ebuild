# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-2.1.10.ebuild,v 1.3 2012/06/26 05:02:43 floppym Exp $

EAPI="3"
PYTHON_DEPEND="*"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython *-pypy-*"

inherit multilib python toolchain-funcs eutils

EXTRAS_VER="1.21"
SEMNG_VER="2.1.6"
SELNX_VER="2.1.9"
SEPOL_VER="2.1.4"

IUSE="audit pam dbus"

DESCRIPTION="SELinux core utilities"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20120216/${P}.tar.gz
	http://dev.gentoo.org/~swift/patches/policycoreutils/policycoreutils-2.1.10-sesandbox.patch.gz
	http://dev.gentoo.org/~swift/patches/policycoreutils/policycoreutils-2.1.10-fix-makefile-pam-audit.patch.gz
	http://dev.gentoo.org/~swift/patches/policycoreutils/policycoreutils-2.1.10-fix-seunshare.patch.gz
	http://dev.gentoo.org/~swift/patches/policycoreutils/policycoreutils-2.1.10-fix-nodbus_or_libcg.patch.gz
	mirror://gentoo/policycoreutils-extra-${EXTRAS_VER}.tar.bz2
	mirror://gentoo/policycoreutils-2.0.85-python3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

COMMON_DEPS=">=sys-libs/libselinux-${SELNX_VER}[python]
	>=sys-libs/glibc-2.4
	>=sys-libs/libcap-1.10-r10
	>=sys-libs/libsemanage-${SEMNG_VER}[python]
	sys-libs/libcap-ng
	>=sys-libs/libsepol-${SEPOL_VER}
	sys-devel/gettext
	dbus? (
		sys-apps/dbus
		dev-libs/dbus-glib
	)
	audit? ( >=sys-process/audit-1.5.1 )
	pam? ( sys-libs/pam )"

### libcgroup -> seunshare
### dbus -> restorecond

# pax-utils for scanelf used by rlpkg
RDEPEND="${COMMON_DEPS}
	dev-python/sepolgen
	app-misc/pax-utils"

DEPEND="${COMMON_DEPS}"

S2=${WORKDIR}/policycoreutils-extra

src_prepare() {
	# rlpkg is more useful than fixfiles
	sed -i -e '/^all/s/fixfiles//' "${S}/scripts/Makefile" \
		|| die "fixfiles sed 1 failed"
	sed -i -e '/fixfiles/d' "${S}/scripts/Makefile" \
		|| die "fixfiles sed 2 failed"
	# We currently do not support MCS, so the sandbox code in policycoreutils
	# is not usable yet. However, work for MCS is on the way and a reported
	# vulnerability (bug #374897) might go by unnoticed if we ignore it now.
	# As such, we will
	# - prepare support for switching name from "sandbox" to "sesandbox"
	epatch "${DISTDIR}/policycoreutils-2.1.10-sesandbox.patch.gz"
	# Disable auto-detection of PAM and audit related stuff and override
	epatch "${DISTDIR}/policycoreutils-2.1.10-fix-makefile-pam-audit.patch.gz"
	# - Fix build failure on seunshare
	epatch "${DISTDIR}/policycoreutils-2.1.10-fix-seunshare.patch.gz"
	# - Make sandbox & dbus-depending stuff (restorecond) USE-triggered
	epatch "${DISTDIR}/policycoreutils-2.1.10-fix-nodbus_or_libcg.patch.gz"
	# Overwrite gl.po, id.po and et.po with valid PO file
	cp "${S}/po/sq.po" "${S}/po/gl.po" || die "failed to copy ${S}/po/sq.po to gl.po"
	cp "${S}/po/sq.po" "${S}/po/id.po" || die "failed to copy ${S}/po/sq.po to id.po"
	cp "${S}/po/sq.po" "${S}/po/et.po" || die "failed to copy ${S}/po/sq.po to et.po"
	# Fixed scripts for Python 3 support
	cp "${WORKDIR}/seobject.py" "${S}/semanage/seobject.py" || die "failed to copy seobject.py"
	cp "${WORKDIR}/semanage" "${S}/semanage/semanage" || die "failed to copy semanage"
	cp "${WORKDIR}/chcat" "${S}/scripts/chcat" || die "failed to copy chcat"
	cp "${WORKDIR}/audit2allow" "${S}/audit2allow/audit2allow" || die "failed to copy audit2allow"
}

src_compile() {
	local use_audit="n";
	local use_pam="n";
	local use_dbus="n";
	local use_sesandbox="n";

	use audit && use_audit="y";
	use pam && use_pam="y";
	use dbus && use_dbus="y";

	python_copy_sources semanage sandbox
	building() {
		einfo "Compiling policycoreutils"
		emake -C "${S}" AUDIT_LOG_PRIVS="y" AUDITH="${use_audit}" PAMH="${use_pam}" INOTIFYH="${use_dbus}" SESANDBOX="${use_sesandbox}" CC="$(tc-getCC)" PYLIBVER="python$(python_get_version)" || die
		einfo "Compiling policycoreutils-extra "
		emake -C "${S2}" AUDIT_LOG_PRIVS="y" AUDITH="${use_audit}" PAMH="${use_pam}" INOTIFYH="${use_dbus}" SESANDBOX="${use_sesandbox}" CC="$(tc-getCC)" PYLIBVER="python$(python_get_version)" || die
	}
	python_execute_function -s --source-dir semanage building
}

src_install() {
	local use_audit="n";
	local use_pam="n";
	local use_dbus="n";
	local use_sesandbox="n";

	use audit && use_audit="y";
	use pam && use_pam="y";
	use dbus && use_dbus="y";

	# Python scripts are present in many places. There are no extension modules.
	installation() {
		einfo "Installing policycoreutils"
		emake -C "${S}" DESTDIR="${T}/images/${PYTHON_ABI}" AUDITH="${use_audit}" PAMH="${use_pam}" INOTIFYH="${use_dbus}" SESANDBOX="${use_sesandbox}" AUDIT_LOG_PRIV="y" PYLIBVER="python$(python_get_version)" install || return 1

		einfo "Installing policycoreutils-extra"
		emake -C "${S2}" DESTDIR="${T}/images/${PYTHON_ABI}" SHLIBDIR="${D}$(get_libdir)/rc" install || return 1
	}
	python_execute_function installation
	python_merge_intermediate_installation_images "${T}/images"

	# remove redhat-style init script
	rm -fR "${D}/etc/rc.d"

	# compatibility symlinks
	dosym /sbin/setfiles /usr/sbin/setfiles
	dosym /$(get_libdir)/rc/runscript_selinux.so /$(get_libdir)/rcscripts/runscript_selinux.so

	# location for permissive definitions
	dodir /var/lib/selinux
	keepdir /var/lib/selinux
}

pkg_postinst() {
	python_mod_optimize seobject.py
}

pkg_postrm() {
	python_mod_cleanup seobject.py
}
