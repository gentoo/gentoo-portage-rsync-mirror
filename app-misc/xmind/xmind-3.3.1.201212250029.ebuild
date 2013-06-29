# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/xmind/xmind-3.3.1.201212250029.ebuild,v 1.3 2013/06/29 03:01:22 creffett Exp $

EAPI=5

inherit eutils multilib fdo-mime gnome2-utils

MY_PN="${PN}-portable"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A brainstorming and mind mapping software tool."
HOMEPAGE="http://www.xmind.net"
SRC_URI="http://dl2.xmind.net/xmind-downloads/${MY_P}.zip
	http://dev.gentoo.org/~creffett/distfiles/xmind-icons.tar.xz"
LICENSE="EPL-1.0 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=virtual/jre-1.5
	x11-libs/gtk+:2
"
RDEPEND="${DEPEND}"

S=${WORKDIR}

QA_PRESTRIPPED="/usr/$(get_libdir)/xmind/XMind/libcairo-swt.so"
QA_FLAGS_IGNORED="
	/usr/$(get_libdir)/xmind/Commons/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.1.200.v20120522-1813/eclipse_1502.so
	/usr/$(get_libdir)/xmind/Commons/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_1.1.200.v20120522-1813/eclipse_1502.so
	/usr/$(get_libdir)/xmind/XMind/libcairo-swt.so
	/usr/$(get_libdir)/xmind/XMind/XMind
"

src_configure() {
	if use amd64; then
		XDIR="XMind_Linux_64bit"
	else
		XDIR="XMind_Linux"
	fi
	mv -v "$XDIR" XMind
	mv -v XMind/.eclipseproduct XMind/configuration Commons

	# force data instance & config area to be at home/.xmind directory
	sed -i -e '/-configuration/d' XMind/XMind.ini || die
	sed -i -e '/\.\/configuration/d' XMind/XMind.ini || die
	sed -i -e '/-data/d' XMind/XMind.ini || die
	sed -i -e '/\.\.\/Commons\/data\/workspace-cathy/d' XMind/XMind.ini || die
	echo '-Dosgi.instance.area=@user.home/.xmind/workspace-cathy' >> XMind/XMind.ini || die
	echo '-Dosgi.configuration.area=@user.home/.xmind/configuration-cathy' >> XMind/XMind.ini || die
}

src_compile() {
	:;
}

src_install() {
	libdir="$(get_libdir)"
	dodir   "/usr/${libdir}/xmind"
	insinto "/usr/${libdir}/xmind"
	doins   -r Commons
	doins   -r XMind

	exeinto "/usr/${libdir}/xmind/XMind"
	doexe   XMind/XMind
	dosym   "/usr/${libdir}/xmind/XMind/XMind" /usr/bin/xmind

	# insall icons
	local res
		for res in 16 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins "${WORKDIR}/xmind-icons/xmind.${res}.png" xmind.png
	done

	# insall MIME type
	insinto /usr/share/mime/packages
	doins   "${FILESDIR}/x-xmind.xml"

	# make desktop entry
	make_desktop_entry xmind XMind xmind Office "MimeType=application/x-xmind;"
	sed -i -e "/^Exec/s/$/ %F/" "${ED}"/usr/share/applications/*.desktop

	insinto /etc/gconf/schemas
	doins "${FILESDIR}/xmind.schemas"
	dobin "${FILESDIR}/xmind-thumbnailer"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
	elog "For audio notes support, install media-sound/lame"
}

pkg_postrm() {
	gnome2_icon_cache_update
}
