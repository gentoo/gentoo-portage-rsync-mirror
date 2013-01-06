# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/backintime/backintime-1.0.8-r1.ebuild,v 1.1 2011/11/10 23:53:47 xmw Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="A simple backup system inspired by TimeVault and FlyBack, with a GUI for GNOME and KDE4"
HOMEPAGE="http://backintime.le-web.org/"
SRC_URI="http://backintime.le-web.org/download/${PN}/${P}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde gnome"

DEPEND="
	net-misc/rsync[xattr,acl]
	kde? (
		>=kde-base/kdelibs-4
		kde-base/pykde4
		kde-base/kompare
		kde-base/kdesu
		)
	gnome? (
		gnome-base/libglade
		dev-util/meld
		gnome-base/gnome-session
		dev-python/gnome-vfs-python
		dev-python/libgnome-python
		dev-python/pygobject:2
		dev-python/pygtk
		)
	dev-python/notify-python"

RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.4-dont-install-license.diff
	epatch "${FILESDIR}"/${PN}-1.0.4-fix-configure-warning.diff
	#fix doc install location
	sed -i "s:/doc/kde4/HTML/:/doc/HTML/:g" kde4/Makefile.template || die
	sed -i "s:/doc/backintime:/doc/${PF}:g" common/Makefile.template || die

	cp "${FILESDIR}"/backintime-1.0.4-kde4-root.desktop \
		kde4/backintime-kde4-root.desktop || die

	epatch "${FILESDIR}"/${PN}-1.0.6-wrapper.patch
	sed -e "/^python /s:^python:$(PYTHON -a):" \
		-e "/^APP_PATH=/s:/usr:${EPREFIX}/usr:" \
		-i common/backintime \
		-i gnome/backintime-gnome \
		-i kde4/backintime-kde4 || die
}

src_configure() {
	cd "${S}"/common || die
	econf

	if use kde ; then
		cd "${S}"/kde4 || die
		econf
	fi

	if use gnome ; then
		cd "${S}"/gnome || die
		econf
	fi
}

src_compile() {
	emake -C common || die

	if use kde ; then
		emake -C kde4 || die
	fi

	if use gnome ; then
		emake -C gnome || die
	fi
}

src_install() {
	emake DESTDIR="${D}" -C common install || die

	if use kde ; then
		emake DESTDIR="${D}" -C kde4 install || die
	fi

	if use gnome ; then
		emake DESTDIR="${D}" -C gnome install || die
	fi

	rm "${ED}"/usr/share/doc/${PF}/LICENSE || die
}
