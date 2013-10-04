# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fast-stemmer/fast-stemmer-1.0.2-r1.ebuild,v 1.1 2013/10/04 18:23:55 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README"

inherit multilib ruby-fakegem

DESCRIPTION="Simple wrapper around multithreaded Porter stemming algorithm"
HOMEPAGE="https://github.com/romanbsd/fast-stemmer"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_prepare() {
	rm ext/Makefile || die
}

each_ruby_configure() {
	${RUBY} -Cext extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext
	cp ext/stemmer$(get_modname) lib/ || die
}

each_ruby_test() {
	${RUBY} -Ilib -S testrb test/fast_stemmer_test.rb || die
}
