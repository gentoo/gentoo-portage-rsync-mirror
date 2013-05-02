# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/swiftiply/swiftiply-0.6.4.ebuild,v 1.3 2013/05/02 19:24:32 tomwij Exp $

EAPI="5"

USE_RUBY="ruby18"
inherit ruby-ng ruby-fakegem

DESCRIPTION="A clustering proxy server for web applications."
HOMEPAGE="http://swiftiply.swiftcore.org/"
SRC_URI="https://github.com/wyhaines/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-ruby/eventmachine-0.9.0"

RUBY_FAKEGEM_EXTRAINSTALL="src"
RUBY_PATCHES=(
	"${FILESDIR}/${P}-test-deque-fix.patch"
	"${FILESDIR}/${P}-cache-base-mixin-fix.patch"
	"${FILESDIR}/${P}-test-http-headers-order-fix.patch"
)

QA_PRESTRIPPED="usr/lib/fastfilereaderext.so
	usr/lib32/fastfilereaderext.so
	usr/lib64/fastfilereaderext.so
	usr/lib/deque.so
	usr/lib32/deque.so
	usr/lib64/deque.so"

each_ruby_configure() {
	cd ext/deque || die 'No deque directory.'
	ruby extconf.rb || die 'Failed to configure deque.'
}

each_ruby_compile() {
	sed -i '/build_ext/q' setup.rb || die 'Rewrite of extension build script failed.'
	echo '}' >> setup.rb || die 'Rewrite of extension build script failed.'

	ruby setup.rb || die 'Failed to setup.'

	cd ext/deque
	emake
}

each_ruby_install() {
	all_fakegem_install

	dolib ext/deque/deque.so ext/fastfilereader/fastfilereaderext.so
}

each_ruby_test() {
	ruby test/TC_Deque.rb || die "Test Case [Deque] failed."
	ruby test/TC_ProxyBag.rb || die "Test Case [ProxyBag] failed."
	ruby test/TC_Swiftiply.rb || die "Test Case [Swiftiply] failed."
}
