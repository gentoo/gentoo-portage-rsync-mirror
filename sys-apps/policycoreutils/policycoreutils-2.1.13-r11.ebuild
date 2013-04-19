# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-2.1.13-r11.ebuild,v 1.1 2013/04/19 10:27:45 swift Exp $

EAPI="4"
PYTHON_DEPEND="2:2.7"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython *-pypy-* 3.*"

inherit multilib python toolchain-funcs eutils

EXTRAS_VER="1.28"
SEMNG_VER="2.1.9"
SELNX_VER="2.1.12"
SEPOL_VER="2.1.8"

IUSE="audit pam dbus sesandbox"

DESCRIPTION="SELinux core utilities"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20120924/${P}.tar.gz
http://dev.gentoo.org/~swift/patches/policycoreutils/patchbundle-${P}-gentoo-r5.tar.gz
	mirror://gentoo/policycoreutils-extra-${EXTRAS_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPS=">=sys-libs/libselinux-${SELNX_VER}[python]
	>=sys-libs/glibc-2.4
	>=sys-libs/libcap-1.10-r10
	>=sys-libs/libsemanage-${SEMNG_VER}[python]
	sys-libs/libcap-ng
	>=sys-libs/libsepol-${SEPOL_VER}
	sys-devel/gettext
	dev-python/ipy
	sesandbox? ( dev-libs/libcgroup )
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

	EPATCH_MULTI_MSG="Applying policycoreutils patches ... " \
	EPATCH_SUFFIX="patch" \
	EPATCH_SOURCE="${WORKDIR}/gentoo-patches" \
	EPATCH_FORCE="yes" \
	epatch

	# Overwrite gl.po, id.po and et.po with valid PO file
	cp "${S}/po/sq.po" "${S}/po/gl.po" || die "failed to copy ${S}/po/sq.po to gl.po"
	cp "${S}/po/sq.po" "${S}/po/id.po" || die "failed to copy ${S}/po/sq.po to id.po"
	cp "${S}/po/sq.po" "${S}/po/et.po" || die "failed to copy ${S}/po/sq.po to et.po"

	epatch_user
}

src_compile() {
	local use_audit="n";
	local use_pam="n";
	local use_dbus="n";
	local use_sesandbox="n";

	use audit && use_audit="y";
	use pam && use_pam="y";
	use dbus && use_dbus="y";
	use sesandbox && use_sesandbox="y";

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
	use sesandbox && use_sesandbox="y";

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
