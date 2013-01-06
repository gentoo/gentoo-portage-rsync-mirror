# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beets/beets-1.0_beta15.ebuild,v 1.1 2012/08/21 21:23:33 sochotnicky Exp $

EAPI="4"

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
#There a few test failures with 2.6, worth investigating
RESTRICT_PYTHON_ABIS="2.5 3.* 2.7-pypy-*"

inherit distutils

MY_PV=${PV/_beta/b}
MY_P=${PN}-${MY_PV}

DESCRIPTION="A media library management system for obsessive-compulsive music geeks"
SRC_URI="http://beets.googlecode.com/files/${MY_P}.tar.gz"
HOMEPAGE="http://beets.radbox.org/"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MIT"
IUSE="chroma doc lastgenre bpd replaygain web"

RDEPEND="
	dev-python/munkres
	dev-python/python-musicbrainz-ngs
	dev-python/unidecode
	media-libs/mutagen
	chroma? ( dev-python/pyacoustid )
	lastgenre? ( dev-python/pylast )
	bpd? ( dev-python/bluelet )
	replaygain? ( media-sound/rgain )
	web? ( dev-python/flask )
	doc? ( dev-python/sphinx )"

DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}

src_prepare() {
	distutils_src_prepare

	# remove plugins that do not have appropriate dependencies installed
	for flag in lastgenre bpd web chroma replaygain;do
		if ! use $flag ; then
			rm -r beetsplug/$flag* || \
				die "Unable to remove $flag plugin"
		fi
	done

	for flag in lastgenre bpd web;do
		if ! use $flag ; then
			sed -i "s:'beetsplug.$flag',::" setup.py || \
				die "Unable to disable $flag plugin "
		fi
	done

	use bpd || rm -f test/test_player.py
}

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_test() {
	cd test
	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" testall.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	doman man/beet.1 man/beetsconfig.5

	use doc && dohtml -r docs/_build/html/
}
