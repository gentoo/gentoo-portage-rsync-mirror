# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-cola/git-cola-1.7.7.ebuild,v 1.1 2012/05/11 09:42:03 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit distutils eutils

DESCRIPTION="The highly caffeinated git GUI"
HOMEPAGE="http://git-cola.github.com/"
SRC_URI="mirror://github/${PN}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="
	dev-python/jsonpickle
	dev-python/pyinotify
	dev-python/PyQt4
	dev-vcs/git"
DEPEND="${RDEPEND}
	doc? (
		app-text/asciidoc
		dev-python/sphinx
		app-text/xmlto )
	sys-devel/gettext
	test? ( dev-python/nose )"

# tests currently broken due to unfinished translation framework
RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# don't install docs into wrong location
	sed -i \
		-e '/doc/d' \
		setup.py || die "sed failed"

	sed -i \
		-e  "s|'doc', 'git-cola'|'doc', '${PF}', 'html'|" \
		cola/resources.py || die "sed failed"

	epatch "${FILESDIR}"/1.3.8-disable-tests.patch

	python_convert_shebangs 2 bin/git-cola bin/git-dag share/git-cola/bin/ssh-askpass
}

src_compile() {
	distutils_src_compile

	if use doc ; then
		cd share/doc/git-cola/
		emake all
	fi
}

src_install() {
	distutils_src_install

	dodoc share/doc/git-cola/*.txt

	if use doc ; then
		dohtml -r _build/html/*
		doman *.1
	else
		dohtml "${FILESDIR}/index.html"
	fi
}

src_test() {
	PYTHONPATH="${S}:${S}/build/lib:${PYTHONPATH}" LC_ALL="C" nosetests \
		--verbose --with-doctest --with-id --exclude=jsonpickle --exclude=json \
		|| die "running nosetests failed"
}

pkg_postinst() {
	python_mod_optimize /usr/share/git-cola/lib/cola
}

pkg_postrm() {
	python_mod_cleanup /usr/share/git-cola/lib/cola
}
