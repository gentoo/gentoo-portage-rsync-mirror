# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-printer-gnome/system-config-printer-gnome-1.4.1.ebuild,v 1.1 2013/08/11 20:05:15 eva Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )
PYTHON_REQ_USE="xml"

inherit autotools eutils fdo-mime python-single-r1 versionator

MY_P="${PN%-gnome}-${PV}"
MY_V="$(get_version_component_range 1-2)"

DESCRIPTION="GNOME frontend for a Red Hat's printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="http://cyberelk.net/tim/data/system-config-printer/${MY_V}/${MY_P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
SLOT="0"
IUSE="gnome-keyring"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# Needs cups running, bug 284005
RESTRICT="test"

# Additional unhandled dependencies
# gnome-extra/gnome-packagekit[${PYTHON_USEDEP}] with pygobject:2 ?
# python samba client: smbc
# selinux: needed for troubleshooting
RDEPEND="
	${PYTHON_DEPS}
	~app-admin/system-config-printer-common-${PV}
	dev-python/pycairo[${PYTHON_USEDEP}]
	>=dev-python/pycups-1.9.60[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
	x11-libs/pango[introspection]
	gnome-keyring? ( gnome-base/libgnome-keyring[introspection] )
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/xmlto-0.0.22
	dev-util/desktop-file-utils
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

APP_LINGUAS="ar as bg bn_IN bn br bs ca cs cy da de el en_GB es et fa fi fr gu
he hi hr hu hy id is it ja ka kn ko lo lv mai mk ml mr ms nb nl nn or pa pl
pt_BR pt ro ru si sk sl sr@latin sr sv ta te th tr uk vi zh_CN zh_TW"
for X in ${APP_LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

S="${WORKDIR}/${MY_P}"

# Bug 471472
MAKEOPTS+=" -j1"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4.1-split.patch
	eautoreconf
}

src_configure() {
	local myconf

	# Disable installation of translations when LINGUAS not chosen
	if [[ -z "${LINGUAS}" ]]; then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls"
	fi

	econf \
		--with-desktop-vendor=Gentoo \
		--without-udev-rules \
		${myconf}
}

src_install() {
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	emake DESTDIR="${ED}" install || die "emake install failed"

	python_fix_shebang "${ED}"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
