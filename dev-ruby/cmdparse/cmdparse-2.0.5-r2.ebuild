# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cmdparse/cmdparse-2.0.5-r2.ebuild,v 1.1 2013/12/27 02:43:18 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_DOCDIR="doc/output/rdoc"
RUBY_FAKEGEM_EXTRADOC="README TODO VERSION"

inherit ruby-fakegem

IUSE=""

DESCRIPTION="Advanced command line parser supporting commands"
HOMEPAGE="http://cmdparse.rubyforge.org/"

KEYWORDS="~amd64 ~ppc64 ~x86"
LICENSE="LGPL-3"
SLOT="0"

each_ruby_test() {
	${RUBY} -Ilib net.rb stat || die "test failed"
}
