# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kudzu/kudzu-1.2.83-r1.ebuild,v 1.2 2012/02/25 03:32:18 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit eutils multilib python rpm toolchain-funcs

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="3"

MY_P="${PN/lib}-${PV}"

DESCRIPTION="Red Hat Hardware detection tools"
#SRC_URI="mirror://fedora/development/source/SRPMS/${MY_P}-${RPMREV}.src.rpm"
#Workaround to get this file on the Gentoo Mirrors for now. -darkside
SRC_URI="http://fedora.mirror.iweb.ca/releases/test/9-Beta/Fedora/source/SRPMS/kudzu-1.2.83-3.src.rpm"
HOMEPAGE="http://rhlinux.redhat.com/kudzu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-lang/python
	dev-libs/popt
	sys-apps/hwdata-redhat
	!sys-libs/libkudzu"
DEPEND="dev-libs/popt
	>=sys-apps/pciutils-2.2.4"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	PYTHON_VERSIONS=
	python_pkg_setup
	local version
	for version in ${PYTHON_ABIS}; do
		PYTHON_VERSIONS+="${PYTHON_VERSIONS:+ }python${version}"
	done
}

src_prepare() {
	sed -i -e 's/make/$(MAKE)/g' \
	-e 's/$(CC) -o/$(CC) $(LDFLAGS) -o/' \
	Makefile || die
}

src_compile() {
	emake \
		all \
		CC=$(tc-getCC) \
		AR=$(tc-getAR) \
		RANLIB=$(tc-getRANLIB) \
		RPM_OPT_FLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		PYTHONVERS="${PYTHON_VERSIONS}" \
		|| die "emake failed"
}

src_install() {
	emake \
		install \
		install-program \
		DESTDIR="${D}" \
		libdir="${D}/usr/$(get_libdir)" \
		CC=$(tc-getCC) \
		PYTHONVERS="${PYTHON_VERSIONS}" \
		|| die "emake install failed"

	# don't install incompatible init scripts
	rm -fr "${D}etc/rc.d" || die "removing rc.d files failed"
}

pkg_postinst() {
	python_mod_optimize kudzu.py
}

pkg_postrm() {
	python_mod_cleanup kudzu.py
}
