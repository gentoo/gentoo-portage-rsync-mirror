# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monkeystudio/monkeystudio-1.9.0.2.ebuild,v 1.3 2013/03/02 21:06:04 hwoarang Exp $

EAPI=4
LANGS="be es fr ru"

inherit qt4-r2

MY_P="mks_${PV}-src"

DESCRIPTION="A cross platform Qt 4 IDE"
HOMEPAGE="http://www.monkeystudio.org"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-3"
SLOT="0"
IUSE="doc plugins"

RDEPEND="plugins? ( >=dev-qt/qtwebkit-4.7.0:4 )
	>=dev-qt/qthelp-4.7.0:4
	>=dev-qt/qtcore-4.7.0:4
	>=dev-qt/qtgui-4.7.0:4
	>=dev-qt/qtsql-4.7.0:4
	x11-libs/qscintilla"
DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.5.8 )"

DOCS="ChangeLog readme.txt"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# avoid installing every translation
	sed -e "s:datas/\*:datas/apis datas/scripts datas/templates:" \
		-i installs.pri || die "sed installs.pri failed"

	rm -r qscintilla/QScintilla-gpl-snapshot \
		|| die "failed removing bundled qscintilla"

	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 build.pro prefix=/usr system_qscintilla=1

	if use plugins ; then
		eqmake4 plugins/plugins.pro
	fi
}

src_install() {
	qt4-r2_src_install

	if use plugins ; then
		insinto /usr/lib64/monkeystudio
		doins -r bin/plugins/*
	fi

	insinto /usr/share/${PN}/translations
	local lang
	for lang in ${LANGS} ; do
		if use linguas_${lang} ; then
			doins datas/translations/monkeystudio_${lang}.qm
		fi
	done

	fperms 755 /usr/bin/${PN}

	if use doc ; then
		doxygen || die "doxygen failed"
		dohtml -r doc/html/*
	fi
}
