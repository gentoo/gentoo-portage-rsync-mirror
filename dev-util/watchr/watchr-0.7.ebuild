# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/watchr/watchr-0.7.ebuild,v 1.1 2012/01/15 18:05:46 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

# Requires every which we don't have packaged.
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Modern continuous testing (flexible alternative to Autotest)"
HOMEPAGE="http://mynyml.com/ruby/flexible-continuous-testing"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86 ~x86-macos"
SLOT="0"
IUSE=""

# This is an optional dependency, but highly recommended on unix systems
ruby_add_rdepend "dev-ruby/rev"
