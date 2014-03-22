# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mate-system-tools/mate-system-tools-1.6.0.ebuild,v 1.1 2014/03/22 19:00:12 tomwij Exp $

EAPI="5"

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Tools aimed to make easy the administration of UNIX systems"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="caja nfs policykit samba"

RDEPEND="app-text/rarian:0
	>=app-admin/system-tools-backends-2.10.1:0
	dev-libs/atk:0
	dev-libs/dbus-glib:0
	>=dev-libs/glib-2.25.3:2
	>=dev-libs/liboobs-1.1:0
	>=sys-apps/dbus-0.32:0
	sys-libs/cracklib:0
	x11-libs/gdk-pixbuf:2
	x11-libs/pango:0
	>=x11-libs/gtk+-2.19.7:2
	virtual/libintl:0
	caja? ( mate-base/mate-file-manager:0 )
	nfs? ( net-fs/nfs-utils:0 )
	policykit? (
		mate-extra/mate-polkit:0
		>=sys-auth/polkit-0.92:0
	)
	samba? ( >=net-fs/samba-3:0 )"

DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/mate-doc-utils:0
	sys-devel/gettext:*
	virtual/pkgconfig:*
	>=dev-util/intltool-0.35.0:*"

src_prepare() {
	# add -lm to linker, fixed upstream
	sed -i 's:DBUS_LIBS):DBUS_LIBS) -lm:' \
		src/time/Makefile.am || die

	find "${WORKDIR}" -name "*.desktop*" -exec sed -i \
		-e 's:Categories=MATE;:Categories=:g' {} \; || die

	epatch "${FILESDIR}"/${P}-Update-POTFILES-skip.patch

	# Tarball has no proper build system, should be fixed on next release.
	mkdir m4 || die
	autotools_run_tool mate-doc-prepare --force --copy || die
	autotools_run_tool mate-doc-common --copy || die
	eautoreconf

	gnome2_src_prepare
}

src_configure() {
	local myconf
	if ! use nfs && ! use samba; then
		myconf="--disable-shares"
	fi

	gnome2_src_configure \
		${myconf} \
		--disable-static \
		$(use_enable policykit polkit-gtk-mate) \
		$(use_enable caja)
}

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README TODO"
