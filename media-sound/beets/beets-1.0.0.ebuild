# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beets/beets-1.0.0.ebuild,v 1.2 2013/02/20 00:01:07 sochotnicky Exp $

EAPI="4"

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
#There a few test failures with 2.6, worth investigating
RESTRICT_PYTHON_ABIS="2.5 3.* 2.7-pypy-*"

inherit distutils eutils

MY_PV=${PV/_rc/rc}
MY_P=${PN}-${MY_PV}

DESCRIPTION="A media library management system for obsessive-compulsive music geeks"
SRC_URI="http://beets.googlecode.com/files/${MY_P}.tar.gz"
HOMEPAGE="http://beets.radbox.org/"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MIT"
IUSE="bpd chroma convert doc echonest_tempo lastgenre replaygain web"

RDEPEND="
	dev-python/munkres
	dev-python/python-musicbrainz-ngs
	dev-python/unidecode
	media-libs/mutagen
	bpd? ( dev-python/bluelet )
	chroma? ( dev-python/pyacoustid )
	convert? ( media-video/ffmpeg[encode] )
	doc? ( dev-python/sphinx )
	echonest_tempo? ( dev-python/pyechonest )
	lastgenre? ( dev-python/pylast )
	replaygain? ( || ( media-sound/mp3gain media-sound/aacgain ) )
	web? ( dev-python/flask )
"

DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}

src_prepare() {
	distutils_src_prepare

	# we'll need this as long as portage doesn't have proper python
	# namespace support (without this we would try to load modules from
	# previous installation during updates)
	use test && epatch "${FILESDIR}/${PN}-1.0_rc2-test-namespace.patch"

	# remove plugins that do not have appropriate dependencies installed
	for flag in bpd chroma convert echonest_tempo lastgenre replaygain web;do
		if ! use $flag ; then
			rm -r beetsplug/$flag* || \
				die "Unable to remove $flag plugin"
		fi
	done

	for flag in bpd lastgenre web;do
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
