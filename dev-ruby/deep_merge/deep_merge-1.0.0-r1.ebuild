# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/deep_merge/deep_merge-1.0.0-r1.ebuild,v 1.2 2013/12/31 06:53:21 graaff Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="A simple set of utility functions for Hash"
HOMEPAGE="http://trac.misuse.org/science/wiki/DeepMerge"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

each_ruby_test() {
	${RUBY} -S testrb test/test_*.rb || die
}
