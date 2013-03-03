# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-qt/vim-qt-20130201.ebuild,v 1.2 2013/03/02 19:22:35 hwoarang Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )
PYTHON_REQ_USE="threads"
inherit eutils fdo-mime flag-o-matic python-any-r1

DESCRIPTION="Qt GUI version of the Vim text editor"
HOMEPAGE="https://bitbucket.org/equalsraf/vim-qt/wiki/Home"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="https://bitbucket.org/equalsraf/${PN}.git
		git://github.com/equalsraf/${PN}.git
		git://gitorious.org/${PN}/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/equalsraf/${PN}/archive/package-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-package-${PV}"
fi

LICENSE="vim"
SLOT="0"
IUSE="acl cscope debug gpm nls perl python ruby"

RDEPEND="app-admin/eselect-vi
	>=app-editors/vim-core-7.3.762[acl?]
	sys-libs/ncurses
	>=dev-qt/qtcore-4.7.0:4
	>=dev-qt/qtgui-4.7.0:4
	acl? ( kernel_linux? ( sys-apps/acl ) )
	cscope? ( dev-util/cscope )
	gpm? ( sys-libs/gpm )
	nls? ( virtual/libintl )
	perl? ( dev-lang/perl )
	python? ( ${PYTHON_DEPS} )
	ruby? ( || ( dev-lang/ruby:1.9 dev-lang/ruby:1.8 ) )"
DEPEND="${RDEPEND}"

pkg_setup() {
	export LC_COLLATE="C" # prevent locale brokenness bug #82186
	use python && python-any-r1_pkg_setup
}

src_configure() {
	use debug && append-flags "-DDEBUG"

	local myconf="--with-features=huge --enable-multibyte"
	myconf+=" $(use_enable acl)"
	myconf+=" $(use_enable gpm)"
	myconf+=" $(use_enable nls)"
	myconf+=" $(use_enable perl perlinterp)"
	myconf+=" $(use_enable python pythoninterp)"
	myconf+=" $(use_enable ruby rubyinterp)"
	myconf+=" --enable-gui=qt --with-vim-name=qvim --with-x"

	if ! use cscope ; then
		sed -i -e '/# define FEAT_CSCOPE/d' src/feature.h || die 'sed failed'
	fi
	econf ${myconf}
}

src_install() {
	dobin src/qvim
	doicon -s 64 src/qt/icons/vim-qt.png
	make_desktop_entry qvim Vim-qt vim-qt "Qt;TextEditor;Development;"
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
