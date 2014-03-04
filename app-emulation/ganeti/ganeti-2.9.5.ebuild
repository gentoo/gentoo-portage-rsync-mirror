# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/ganeti/ganeti-2.9.5.ebuild,v 1.2 2014/03/04 00:12:09 chutzpah Exp $

EAPI=5
PYTHON_COMPAT=(python2_{6,7})
use test && PYTHON_REQ_USE="ipv6"

inherit eutils confutils autotools bash-completion-r1 python-single-r1 versionator

MY_PV="${PV/_rc/~rc}"
#MY_PV="${PV/_beta/~beta}"
MY_P="${PN}-${MY_PV}"
SERIES="$(get_version_component_range 1-2)"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.ganeti.org/ganeti.git"
	inherit git-2
	KEYWORDS=""
	# you will need to pull in the haskell overlay for pandoc
	GIT_DEPEND="app-text/pandoc
		dev-python/docutils
		dev-python/sphinx
		media-libs/gd[fontconfig,jpeg,png,truetype]
		media-gfx/graphviz
		media-fonts/urw-fonts"
else
	SRC_URI="http://downloads.ganeti.org/releases/${SERIES}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Ganeti is a virtual server management software tool"
HOMEPAGE="http://code.google.com/p/ganeti/"

LICENSE="GPL-2"
SLOT="0"
IUSE="kvm xen lxc drbd htools syslog ipv6 haskell-daemons rbd test"
REQUIRED_USE="|| ( kvm xen lxc )"

S="${WORKDIR}/${MY_P}"

HASKELL_DEPS=">=dev-lang/ghc-6.12:0=
		dev-haskell/json:0=
		dev-haskell/curl:0=
		dev-haskell/network:0=
		dev-haskell/parallel
		dev-haskell/hslogger:0=
		dev-haskell/utf8-string:0=
		dev-haskell/deepseq:0="

DEPEND="xen? ( >=app-emulation/xen-3.0 )
	kvm? ( app-emulation/qemu )
	lxc? ( app-emulation/lxc )
	drbd? ( <sys-cluster/drbd-8.5 )
	rbd? ( sys-cluster/ceph )
	ipv6? ( net-misc/ndisc6 )
	haskell-daemons? (
		${HASKELL_DEPS}
		dev-haskell/crypto:0=
		dev-haskell/text:0=
		dev-haskell/hinotify:0=
		dev-haskell/regex-pcre-builtin:0=
		dev-haskell/attoparsec:0=
		dev-haskell/vector:0=
	)
	dev-libs/openssl
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/ipaddr[${PYTHON_USEDEP}]
	dev-python/bitarray[${PYTHON_USEDEP}]
	net-analyzer/arping
	net-analyzer/fping
	net-misc/bridge-utils
	net-misc/curl[ssl]
	net-misc/openssh
	net-misc/socat
	sys-apps/iproute2
	sys-fs/lvm2
	>=sys-apps/baselayout-2.0
	${PYTHON_DEPS}
	${GIT_DEPEND}"
RDEPEND="${DEPEND}
	!app-emulation/ganeti-htools"
DEPEND+="${HASKELL_DEPS}
	test? (
		dev-python/mock
		dev-python/pyyaml
		dev-haskell/test-framework:0=
		dev-haskell/test-framework-hunit:0=
		dev-haskell/test-framework-quickcheck2:0=
		dev-haskell/temporary:0=
		sys-apps/fakeroot
	)"

PATCHES=(
	"${FILESDIR}/${PN}-2.6-fix-args.patch"
	"${FILESDIR}/${PN}-2.6-add-pgrep.patch"
	"${FILESDIR}/${PN}-2.7-fix-tests.patch"
	"${FILESDIR}/${PN}-2.9-disable-root-tests.patch"
	"${FILESDIR}/${PN}-2.9-regex-builtin.patch"
	"${FILESDIR}/${PN}-2.9-skip-cli-test.patch"
)

pkg_setup () {
	confutils_use_depend_all haskell-daemons htools
	python-single-r1_pkg_setup
}

src_prepare() {
	epatch "${PATCHES[@]}"
	has_version ">=sys-devel/automake-1.13" && epatch "${FILESDIR}/${PN}-2.9-automake-1.13.patch"
	[[ ${PV} == "9999" ]] && ./autogen.sh
	rm autotools/missing
	eautoreconf
}

src_configure () {
	econf --localstatedir=/var \
		--docdir=/usr/share/doc/${P} \
		--with-ssh-initscript=/etc/init.d/sshd \
		--with-export-dir=/var/lib/ganeti-storage/export \
		--with-os-search-path=/usr/share/ganeti/os \
		$(use_enable syslog) \
		$(usex kvm '--with-kvm-path=' '' '/usr/bin/qemu-kvm' '') \
		$(usex haskell-daemons "--enable-confd=haskell" '' '' '')
}

src_install () {
	emake V=1 DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}"/ganeti-2.2.initd ganeti
	newconfd "${FILESDIR}"/ganeti.confd ganeti
	use kvm && newinitd "${FILESDIR}"/ganeti-kvm-poweroff.initd ganeti-kvm-poweroff
	use kvm && newconfd "${FILESDIR}"/ganeti-kvm-poweroff.confd ganeti-kvm-poweroff
	newbashcomp doc/examples/bash_completion ganeti
	dodoc INSTALL UPGRADE NEWS README doc/*.rst
	dohtml -r doc/html/*
	rm -rf "${D}"/usr/share/doc/ganeti

	docinto examples
	dodoc doc/examples/{ganeti.cron,gnt-config-backup} doc/examples/*.ocf

	docinto examples/hooks
	dodoc doc/examples/hooks/{ipsec,ethers}

	insinto /etc/cron.d
	newins doc/examples/ganeti.cron ${PN}

	insinto /etc/logrotate.d
	newins doc/examples/ganeti.logrotate ${PN}

	python_fix_shebang "${D}"/usr/sbin/ "${D}"/usr/"$(get_libdir)"/ganeti/ensure-dirs

	keepdir /var/{lib,log,run}/ganeti/
	keepdir /usr/share/ganeti/os/
	keepdir /var/lib/ganeti-storage/{export,file,shared}/

	python_fix_shebang "${ED}"
}

src_test () {
	emake check || die "emake check failed"
}
