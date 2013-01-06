# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/xfburn/xfburn-0.4.3_p20121021.ebuild,v 1.4 2012/11/28 12:35:38 ssuominen Exp $

EAPI=5
#EAUTORECONF=yes
inherit autotools xfconf

DESCRIPTION="GTK+ based CD and DVD burning application"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfburn"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug gstreamer udev"

RDEPEND=">=dev-libs/glib-2.30
	>=dev-libs/libburn-0.4.2
	>=dev-libs/libisofs-0.6.2
	>=x11-libs/gtk+-2.24:2
	>=xfce-base/exo-0.6
	>=xfce-base/libxfce4ui-4.10
	gstreamer? ( >=media-libs/gst-plugins-base-0.10.20:0.10 )
	udev? ( virtual/udev[gudev] )"
# dev-libs/libxslt -> xsltproc -> --enable-maintainer-mode -> docs/Makefile.am
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/intltool
	>=dev-util/xfce4-dev-tools-4.10
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		--enable-maintainer-mode
		$(use_enable udev gudev)
		$(use_enable gstreamer)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}

src_prepare() {
	# .in.in -> .in
	sed -i -e '/^exec.*xdt-autogen/d' autogen.sh || die
	./autogen.sh

	# Prevent glib-gettextize from running wrt #420639
	intltoolize --automake --copy --force
	_elibtoolize --copy --force --install
	AT_M4DIR=${EPREFIX}/usr/share/xfce4/dev-tools/m4macros eaclocal
	eautoconf
	eautoheader
	eautomake

	xfconf_src_prepare
}
