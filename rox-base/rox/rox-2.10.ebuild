# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox/rox-2.10.ebuild,v 1.8 2014/08/10 20:32:37 slyfox Exp $

EAPI=2
inherit eutils multilib

MY_P="rox-filer-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="ROX is a desktop environment and filer based on RISC OS"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="mirror://sourceforge/rox/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="+svg +video"

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	dev-libs/libxml2:2
	>=x11-misc/shared-mime-info-0.14
	svg? ( gnome-base/librsvg:2 )
	>=rox-base/zeroinstall-injector-0.40
	"

PDEPEND="rox-base/mime-editor
		rox-base/thumbs
		video? ( rox-extra/videothumbnail )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

APPNAME="ROX-Filer"
APPDIR="/usr/$(get_libdir)/rox"
LIBDIR="/usr/$(get_libdir)/"
WRAPPERNAME="rox"
MIMEDIR="/usr/share/mime"
MIMECONFDIR="/etc/xdg/rox.sourceforge.net"

src_prepare() {
	epatch "${FILESDIR}"/${P}-nostrip.patch
}

src_compile() {
	cd ${APPNAME}

	mkdir build
	pushd build
	../src/configure
	emake
	popd

	# don't need these directories anymore
	if [ -n "${KEEP_SRC}" ]; then
		pushd src
		make clean > /dev/null
		popd
	else
		rm -rf src
	fi
	rm -fr build
}

# new streamlined install

src_install() {
	doman rox.1

	dodir ${APPDIR}
	cp -r ${APPNAME}/ "${D}/${APPDIR}"

	# add documentation to be proper
	pushd ${APPNAME}/Help
	dodoc Changes README README-es TODO
	popd

	# install shell script
	dodir /usr/bin

	cat >"${D}/usr/bin/${WRAPPERNAME}" <<EOF
#!/bin/sh
if [ "\${LIBDIRPATH}" ]; then
	export LIBDIRPATH="\${LIBDIRPATH}:${LIBDIR}"
else
	export LIBDIRPATH="${LIBDIR}"
fi

if [ "\${APPDIRPATH}" ]; then
	export APPDIRPATH="\${APPDIRPATH}:${APPDIR}"
else
	export APPDIRPATH="${APPDIR}"
fi
exec "${APPDIR}/${APPNAME}/AppRun" "\$@"
EOF

	cat >"${D}/usr/bin/${WRAPPERNAME}uri" <<EOF
#!/bin/sh
exec "${APPDIR}/${APPNAME}/AppRun" -U "\$@"
EOF

	fperms 0755 "/usr/bin/${WRAPPERNAME}"
	fperms 0755 "/usr/bin/${WRAPPERNAME}uri"

	# Do not install rox.xml - It wrecks any app with a SVG-format .DirIcon
	#insinto ${MIMEDIR}/packages
	#doins rox.xml

	# CHOICES system is gone. Now use XDG only
	# these are shell scripts and must be +x.
	exeinto ${MIMECONFDIR}/MIME-types
	doexe Choices/MIME-types/*

	insinto /usr/share/pixmaps
	newins ${APPNAME}/.DirIcon ${APPNAME}.png

	make_desktop_entry ${WRAPPERNAME} ${APPNAME} ${APPNAME} "System;FileTools;FileManager"

	# Install the 0install feed
	local NATIVE_FEED_DIR="/usr/share/0install.net/native_feeds"
	local ICON_CACHE_DIR="/var/cache/0install.net/interface_icons"

	0distutils ${APPNAME}.xml > tmp.native_feed || die "0distutils feed edit	failed"
	insinto "${APPDIR}/${APPNAME}"
	newins tmp.native_feed ${APPNAME}.xml

	local feedname
	feedname=$(0distutils -e tmp.native_feed) || die "0distutils URI escape	failed"
	dosym "${APPDIR}/${APPNAME}/${APPNAME}.xml" "${NATIVE_FEED_DIR}/${feedname}"

	local cachedname
	cachedname=$(0distutils -c tmp.native_feed) || die "0distutils URI escape	failed"
	dosym "${APPDIR}/${APPNAME}/.DirIcon" "${ICON_CACHE_DIR}/${cachedname}"
}

pkg_postinst() {
	# Do not install rox.xml - It wrecks any app with a SVG-format .DirIcon
	#update-mime-database ${MIMEDIR}

	einfo "${APPNAME} has been installed in ${APPDIR}."
	einfo "To run, you may type ${WRAPPERNAME} at a prompt (within a WM) or"
	einfo "add it to an .xinit or other script during WM startup."
}
